<?php

namespace App\Models;

use PDO;
use App\Modules\Token;
use App\Modules\Upload;

class Post extends \Core\Model
{
    public $errors = [];

    public function __construct($data = [])
    {
        foreach ($data as $key => $value) {
            $this->$key = $value;
        }
    }

    public function save()
    {
        $this->validateBeforeSAving($_POST['title'], $_POST['description'], $_POST['category'], $_POST['tags'], $_POST['status'], $_POST['content']);

        if (empty($this->errors )) {
            
            $uploadResult = Upload::singleImage();

            if(is_array($uploadResult)) {
                $this->errors['upload'] = $uploadResult[0];
                
                return false;
            } 

            if ( $uploadResult === 0 ) {
                $uploadResult = '';
            } 

                $sql = 'INSERT INTO post (title, description, content, category, thumbnail, tags, status, slug)
                    VALUES(:title, :description, :content, :category, :thumbnail, :tags, :status, :slug)';

                $db = static::getDB();
                $stmt = $db->prepare($sql);

                $stmt->bindValue(':title', $this->title, PDO::PARAM_STR);
                $stmt->bindValue(':description', $this->description, PDO::PARAM_STR);
                $stmt->bindValue(':content', $this->content, PDO::PARAM_STR);
                $stmt->bindValue(':category', $this->category, PDO::PARAM_INT);
                $stmt->bindValue(':thumbnail', $uploadResult, PDO::PARAM_STR);
                $stmt->bindValue(':tags', $this->tags, PDO::PARAM_STR);
                $stmt->bindValue(':status', $this->status, PDO::PARAM_STR);
                $stmt->bindValue(':slug', $this->create_slug($this->title), PDO::PARAM_STR);
            
                return $stmt->execute();

        }
        return false;
    }

    public static function deleteOne($id){
        $sql = 'DELETE from post WHERE id = :id';

        $db = static::getDB();
        $stmt = $db->prepare($sql);

        $stmt->bindValue(':id', $id, PDO::PARAM_STR);

        return $stmt->execute();

    }

    /**
     * Getter functions
     */

    public static function getAll()
    {
        $db = static::getDB();
        $stmt = $db->query('SELECT title, date_created, date_modified, name, status, post.slug, post.id FROM post INNER JOIN category ON post.category = category.id');

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    /**
     * Validation functions
     */

     private function validateBeforeSAving($title, $description, $category, $tags, $status, $content)
     {
        $this->validateTitle($title);
        $this->validateDescription($description);
        $this->validateCategory($category);
        $this->validateTags($tags);
        $this->validateStatus($status);
        $this->validateContent($content);

     }

    private function validateTitle($title)
    {
        if(trim($title) === '') {
            $this->errors['title'] = 'El título no puede estar vacío';
            return;
        }

        if(strlen($title) > 255) {
            $this->errors['title'] = 'El título no puede contener más de 255 caracteres';
            return;
        }
    }

    private function validateDescription($description)
    {
        if (trim($description) === '') {
            $this->errors['description'] = 'La descripción no puede estar vacía';
            return;
        }
        if(strlen($description) > 300) {
            $this->errors['description'] = 'La descripción no puede contener más de 255 caracteres';
            return;
        }
    }

    private function validateCategory($category)
    {
        if (!filter_var($category, FILTER_VALIDATE_INT, array('min_range' => 1))) {
            $this->errors['category'] = 'La categoría es invalida';
            return;
        } 
    }

    private function validateTags($tags)
    {
        if(strlen($tags) > 255) {
            $this->errors['tags'] = 'El contenido de las etiquetas no puede contener más de 255 caracteres';
            return;
        }
    }

    private function validateStatus($status)
    {
        if(!in_array($status, Helper::getAllStatus())) {
            $this->errors['status'] = 'El estado es invalido';
            return;
        } 
    }

    private function validateContent($content)
    {
        if(strlen($content)  == 0) {
            $this->errors['content'] = 'El contenido no puede ser vacío';
            return;
        }   
    }


    /**
     * Trasnformation functions
     */
    private function create_slug($string){
        $slug=preg_replace('/[^A-Za-z0-9-]+/', '-', strtolower($string));
        return $slug;
     }


}