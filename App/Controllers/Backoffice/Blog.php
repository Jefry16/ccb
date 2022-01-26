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

    public function nuevo()
    {
       View::renderTemplate('Backoffice/Blog/blog-new.html', [
        'category' => Category::getAll(),
        'status' => Helper::getAllStatus()
       ]);
    }

    public function guardar()
    {
        $post = new Post($_POST);
        Upload::singleImage();
        exit;
        $inputs = $_POST;
        if($post->save()) {

        } else {
            
            View::renderTemplate('Backoffice/Blog/blog-new.html', [
                'error' => $post->errors,
                'inputs' => $inputs,
                'category' => Category::getAll(),
                'status' => Helper::getAllStatus()
            ]);
        }
        
    }

}