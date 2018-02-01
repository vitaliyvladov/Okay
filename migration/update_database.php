<?php

require_once("api/Okay.php");
$okay = new Okay();

$okay->db->query("SHOW TABLES LIKE 'mi_executed_migration'");
$exist = $okay->db->results();
$already_executed = array();
if (!empty($exist)) {
    $okay->db->query("SELECT `name` FROM mi_executed_migration");
    $already_executed = $okay->db->results('name');
}

foreach (glob(MIGRATION_DIR."sql/*.up.sql") as $path) {
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
