<?php

class Folders {

    private static $denied_files = array(".", "..");

    public static function add_dir($path, $dir) {
        $full_path = $path.$dir;
        if (empty($dir) || !file_exists($path) || file_exists($full_path)) {
            return false;
        }
        return mkdir($full_path);
    }

    public static function remove_dir($path) {
        if (!file_exists($path)) {
            return false;
        }

        if (is_dir($path)) {
            $objects = scandir($path);
            foreach ($objects as $object) {
                if ($object != "." && $object != "..") {
                    if (is_dir($path."/".$object)) {
                        self::remove_dir($path . "/" . $object);
                    } else {
                        unlink($path . "/" . $object);
                    }
                }
            }
            return rmdir($path);
        } else {
            return false;
        }
    }

    public static function add_file($path, $file, $content = "") {
        $full_path = $path.$file;
        if (empty($file) || !file_exists($path) || file_exists($full_path) || in_array($file, self::$denied_files)) {
            return false;
        }
        return file_put_contents($full_path, $content);
    }

    public static function remove_file($path) {
        if (!file_exists($path)) {
            return false;
        }
        return unlink($path);
    }

}