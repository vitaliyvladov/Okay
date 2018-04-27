<?php

ini_set('display_errors', 'off');

$bitbucket_ips = array('34.198.203.127', '34.198.178.64', '34.198.32.85', '127.0.0.1');
$bitbucket_cidrs = array('104.192.136.0/21');
chdir("..");
require_once("api/Okay.php");
$okay = new Okay();
chdir("build");
$path_to_php = $okay->config->path_to_php;

if (in_array($_SERVER['REMOTE_ADDR'], $bitbucket_ips) || cidr_match($_SERVER['REMOTE_ADDR'], $bitbucket_cidrs)) {
    
    $request_body = file_get_contents('php://input');
    $request_body = json_decode($request_body);
    
    // В случае удаления ветки, new будет равен null
    if ($request_body->push->changes[0]->new === null) {
        exit;
    }
    
    switch ($_GET['channel']) {
        case 'dev':
            $branch = 'dev';
        break;
        case 'production':
            $branch = 'production';
        break;
        default:
            print 'wrong channel';
        exit;
    }
    
    // Если прилител хук, но пушили не в ветку которую мы "слушаем", phing запускать не нужно
    if ($request_body->push->changes[0]->new->name != $branch) {
        print 'Other channel'.PHP_EOL;
        exit;
    }
    
    $dir = dirname(__DIR__);
    exec("{$path_to_php}php {$dir}/build/bin/phing.phar -f {$dir}/build/build.xml -Dbranch=\"{$branch}\" -Dphp_path=\"{$path_to_php}\"", $output);
    print 'OK'.PHP_EOL;
    foreach ($output as $out) {
        print $out.PHP_EOL;
    }
} else {
    header('HTTP/1.1 404 Not Found');
    exit;
}

function cidr_match($ip, $ranges) {
    $ranges = (array)$ranges;
    foreach ($ranges as $range) {
        list($subnet, $mask) = explode('/', $range);
        if ((ip2long($ip) & ~((1 << (32 - $mask)) - 1)) == ip2long($subnet)) {
            return true;
        }
    }
    return false;
}
