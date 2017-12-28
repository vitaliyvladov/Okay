<?php

define("ROOT_DIR", dirname(__DIR__)."/");
chdir(ROOT_DIR);

require_once("migration/update_folders.php");
require_once("migration/update_database.php");
