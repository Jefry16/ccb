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

    public static function deleteOne($id){
        $sql = 'DELETE from category WHERE id = :id';

        $db = static::getDB();
        $stmt = $db->prepare($sql);

        $stmt->bindValue(':id', $id, PDO::PARAM_STR);

        return $stmt->execute();

    }

    public static function updateOne($id, $name){
        $sql = 'UPDATE category SET name = :name, modified_at = NOW(), slug = :slug WHERE id = :id';

        $db = static::getDB();
        $stmt = $db->prepare($sql);

        $stmt->bindValue(':id', $id, PDO::PARAM_STR);
        $stmt->bindValue(':name', $name, PDO::PARAM_STR);
        $stmt->bindValue(':slug', Static::create_slug($name), PDO::PARAM_STR);


        return $stmt->execute();

    }

    public static function getAll()
    {
        $db = static::getDB();
        $stmt = $db->query('SELECT id, name, created_at, modified_at FROM category');

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function save()
    {
        $this->validateAll($this->name);

        if (empty($this->errors)) {
            $sql = 'INSERT INTO category (name, slug)VALUES(:name, :slug)';

            $db = static::getDB();
            $stmt = $db->prepare($sql);

            $stmt->bindValue(':name', $this->name, PDO::PARAM_STR);
            $stmt->bindValue(':slug', $this->create_slug($this->name), PDO::PARAM_STR);
            
            return $stmt->execute();

        }
        return false;
    
    }

    private function validateAll($name)
    {
        $this->validateTitle($name);
        $this->validateNotExists($name);
    }

    private function validateTitle($name)
    {
        if(trim($name) === '') {
            $this->errors['title'] = 'El nombre de la categoría no puede estar vacío';
            return;
        }

        if(strlen($name) > 255) {
            $this->errors['title'] = 'El nombre de la categoría no puede contener más de 255 caracteres';
            return;
        }
    }

    private function findByName($name)
    {
        $sql = 'SELECT * from category WHERE name = :name';

        $db = static::getDB();
        $stmt = $db->prepare($sql);

        $stmt->bindValue(':name', $name, PDO::PARAM_STR);
        $stmt->setFetchMode(PDO::FETCH_CLASS, '\App\Models\Category');
        $stmt->execute();

        return $stmt->fetch();
    }

    private function validateNotExists($name)
    {
         if ($this->findByName($name)) {
             $this->errors['title'] = 'Ya existe una categoría con este nombre';
         }
    }

    private static function create_slug($string){
        $slug=preg_replace('/[^A-Za-z0-9-]+/', '-', strtolower($string));
        return $slug;
     }
}