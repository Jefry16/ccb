<?php

namespace App\Controllers\Backoffice;

use App\Models\Category;
use App\Models\Helper;
use App\Models\Post;
use App\Modules\Auth;
use App\Modules\Upload;
use \Core\View;


class Blog extends \Core\Controller
{

    protected function before()
    {
       if(!Auth::getCurrentAdmin()) {
           $this->redirect('/ccb/admin/login');
       }
    }


    public function indexAction()
    {
       View::renderTemplate('Backoffice/Statico/blog-init.html');
    }

    public function nuevoAction()
    {
       View::renderTemplate('Backoffice/Blog/blog-new.html', [
        'category' => Category::getAll(),
        'status' => Helper::getAllStatus()
       ]);
    }

    public function guardarAction()
    {
        $post = new Post($_POST);
        $inputs = $_POST;
        $post->save();
        
        if($post->save()) {

        } else {
            
            View::renderTemplate('Backoffice/Blog/blog-new.html', [
                'error' => $post->errors,
                'inputs' => $inputs,
                'category' => Category::getAll(),
                'status' => Helper::getAllStatus()
            ]);
        }
        var_dump($post->errors);

    }

}