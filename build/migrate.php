<?php
/*
 * params from command line
 * param1 - $argv[1] - action, if empty - action=update
 * param2 - $argv[2] - name of migration for action=create
*/

define("ROOT_DIR", dirname(__DIR__)."/");
define("MIGRATIONS_DIR", ROOT_DIR."build/migrations/");
chdir(ROOT_DIR);

$action = !empty($argv[1]) ? $argv[1] : "update";
switch ($action) {
    case 'update': {
        require_once("api/Okay.php");
        $okay = new Okay();

        $okay->db->query("SHOW TABLES LIKE 'mi_executed_migration'");
        $exist = $okay->db->results();
        $already_executed = array();
        if (!empty($exist)) {
            $okay->db->query("SELECT `name` FROM mi_executed_migration");
            $already_executed = $okay->db->results('name');
        }

        foreach (glob(MIGRATIONS_DIR."*.up.sql") as $path) {
            $file = pathinfo($path, PATHINFO_BASENAME);
            if (!in_array($file, $already_executed)) {
                $errors = $okay->db->restore($path, true);
                $okay->db->query("INSERT INTO mi_executed_migration SET `name`=?", $file);
                echo $file."-----".(!empty($errors) > 0 ? "ERROR" : "OK").PHP_EOL;
                foreach ($errors as $error) {
                    echo $error.PHP_EOL;
                }
                if (!empty($errors)) {
                    echo PHP_EOL;
                }
            }
        }
        break;
    }
    case 'create': {
        $name = date("YmdHis").(empty($argv[2]) ? '' : '_'.$argv[2]).".up.sql";
        fclose(fopen(MIGRATIONS_DIR.$name, "w"));
        break;
    }
    default: {
        echo "error: UNKNOWN ACTION (param1 must be: empty, 'update', 'create')".PHP_EOL;
    }
}
