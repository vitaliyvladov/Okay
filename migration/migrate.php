<?php
/*
 * params from command line
 * param1 - $argv[1] - action, if empty - action=update
 * param2 - $argv[2] - name of migration for action=create
*/

define("ROOT_DIR", dirname(__DIR__)."/");
chdir(ROOT_DIR);

$action = !empty($argv[1]) ? $argv[1] : "update";
switch ($action) {
    case 'update': {
        require_once("migration/update_database.php");
        break;
    }
    case 'create': {
        $name = date("YmdHis").(empty($argv[2]) ? '' : '_'.$argv[2]).".up.sql";
        fclose(fopen(ROOT_DIR."migration/sql/".$name, "w"));
        break;
    }
    default: {
        echo "error: UNKNOWN ACTION (param1 must be: empty, 'update', 'create')".PHP_EOL;
    }
}
