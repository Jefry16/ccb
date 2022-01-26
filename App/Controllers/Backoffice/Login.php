<?php

namespace App\Controllers\Backoffice;

use App\Models\User;
use App\Modules\Auth;
use \Core\View;


class Login extends \Core\Controller
{

    public function indexAction()
    {
       View::renderTemplate('Backoffice/Statico/login.html');
    }

    public function startAction()
    {
        $user = User::authenticate($_POST['email'], $_POST['password']);
        
        if($user) {
            Auth::login($user);
            $this->redirect('/ccb/admin');
        } else {
           View::renderTemplate('Backoffice/Statico/login.html');
        }
    }

}