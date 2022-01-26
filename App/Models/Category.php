<?php

namespace App\Models;

use PDO;
use App\Modules\Token;

class Category extends \Core\Model
{
    public $errors = [];

    public function __construct($data = [])
    {
        foreach ($data as $key => $value) {
            $this->$key = $value;
        }
    }

    public static function getAll()
    {
        $db = static::getDB();
        $stmt = $db->query('SELECT id, name FROM category');
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

}