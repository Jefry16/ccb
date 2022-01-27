<?php

namespace App\Controllers\Backoffice;

use App\Models\Category;
use App\Models\Helper;
use App\Models\Post;
use App\Modules\Auth;
use App\Modules\Flashmessage;
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
        
       View::renderTemplate('Backoffice/Blog/blog-init.html', [
           'posts' => Post::getAll(),
           'categories' => Category::getAll()
       ]);
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

        
        if($post->save()) {

            Flashmessage::set('El post se ha guardado como '. $post->status, Flashmessage::SUCCESS);
            
            $this->redirect('/ccb/admin/blog/index');

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