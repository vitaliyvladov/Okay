<?php

if(!empty($_SERVER['HTTP_USER_AGENT'])){
    session_name(md5($_SERVER['HTTP_USER_AGENT']));
}
session_start();

chdir("..");
require_once("api/Okay.php");
$okay = new Okay();
chdir("build");

ini_set('display_errors', 'off');

$path_to_php = $okay->config->path_to_php;
$bitbucket_key = $okay->config->bitbucket_key;

if (!empty($bitbucket_key) && $bitbucket_key == $okay->request->get('key', 'string')) {
    
    $request_body = file_get_contents('php://input');
    $request_body = json_decode($request_body);
    
    switch ($_GET['channel']) {
        case 'dev':
            $branch = 'dev';
        break;
        case 'production':
            $branch = 'production';
        break;
        default:
            logger('Wrong channel');
        exit;
    }

    // Если не под админом, проверяем что это с битбакета прилетел хук. Иначе деплой запуститься в мануальном режиме
    if (!$_SESSION['admin']) {
        // В случае удаления ветки, new будет равен null
        if ($request_body === null || $request_body->push->changes[0]->new === null) {
            logger('Empty request');
            exit;
        }

        // Если прилител хук, но пушили не в ветку которую мы "слушаем", phing запускать не нужно
        if ($request_body->push->changes[0]->new->name != $branch) {
            logger('Other channel');
            exit;
        }
    }
    
    $dir = dirname(__DIR__);
    exec("{$path_to_php}php {$dir}/build/bin/phing.phar -f {$dir}/build/build.xml -Dbranch=\"{$branch}\" -Dphp_path=\"{$path_to_php}\"", $output);
    foreach ($output as $out) {
        logger($out);
    }
} else {
    logger('Bad key');
    header('HTTP/1.1 404 Not Found');
    exit;
}

function logger($message = null) {
    $logger_file = __DIR__.'/log/deploy.log';
    $logger = "[".date('r')."]";
    if (!empty($message)) {
        $logger .= " Message - \"" . trim($message) . "\"";
    }
    $logger .= PHP_EOL;
    file_put_contents($logger_file, $logger, FILE_APPEND);
}
