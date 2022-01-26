<?php

namespace App\Models;

use PDO;
use App\Modules\Token;

class Helper extends \Core\Model
{
    public $errors = [];

    public function __construct($data = [])
    {
        foreach ($data as $key => $value) {
            $this->$key = $value;
        }
    }

    public static function getAllStatus()
    {
        $db = static::getDB();
        $stmt = $db->query('SELECT COLUMN_TYPE as status FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = "ccb" AND TABLE_NAME = "post" AND COLUMN_NAME = "status"');
        $enum = substr($stmt->fetchAll(PDO::FETCH_ASSOC)[0]['status'], 5, -1);
        $enum = explode(',', $enum);

        $status = [];
        foreach ($enum as $value) {
            $status[] = substr($value, 1, -1);
        }
        return $status;
    }

}