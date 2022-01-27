<?php

namespace App\Controllers\Backoffice;

use App\Models\Category as ModelsCategory;
use App\Models\User;
use App\Modules\Auth;
use App\Modules\Flashmessage;
use \Core\View;

class Category extends \Core\Controller
{
    public function addAction()
    {
        $category = new ModelsCategory($_POST);
        if ($category->save()) {
            Flashmessage::set('La categoría ha sido añadida correctamente', Flashmessage::SUCCESS);
        } else {
            Flashmessage::set($category->errors['title'], Flashmessage::SUCCESS);
        }

        $this->redirect('/ccb/admin/blog/index');
    }
}
