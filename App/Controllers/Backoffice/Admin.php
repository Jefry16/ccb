<?php

namespace App\Controllers\Backoffice;

use App\Modules\Auth;
use \Core\View;


class Admin extends \Core\Controller
{

    protected function before()
    {
       if(!Auth::getCurrentAdmin()) {
           $this->redirect('/ccb/admin/login');
       }
    }


    public function indexAction()
    {
       View::renderTemplate('Backoffice/Statico/welcome.html');
    }

}