<?php
/*
 * params from command line
 * param1 - $argv[1] - action, if empty - action=update
 * param2 - $argv[2] - name of migration for action=create
*/

define("ROOT_DIR", dirname(__DIR__)."/");
define("MIGRATION_DIR", ROOT_DIR."migration/");
chdir(ROOT_DIR);

$action = !empty($argv[1]) ? $argv[1] : "update";
switch ($action) {
    case 'update': {
        require_once(MIGRATION_DIR."update_database.php");
        break;
    }
    case 'create': {
        $name = date("YmdHis").(empty($argv[2]) ? '' : '_'.$argv[2]).".up.sql";
        fclose(fopen(MIGRATION_DIR."sql/".$name, "w"));
        break;
    }
    default: {
        echo "error: UNKNOWN ACTION (param1 must be: empty, 'update', 'create')".PHP_EOL;
    }
}
