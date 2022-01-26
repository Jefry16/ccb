<?php

namespace App\Modules;

use App\Config;

use App\Models\Login;
use App\Models\User;

/**
 * Ajax controller
 *
 * PHP version 7.0
 */
class Auth
{
    public static function login($user)
    {
        $_SESSION['admin_id'] = $user->id;

        session_regenerate_id(true);
        
        Flashmessage::set('Welcome back!', Flashmessage::SUCCESS);

    }

    
/*
    public static function getCurrentMember()
    {
        if (isset($_SESSION[Config::$member_type])) {
            return User::findById($_SESSION[Config::$member_type]);
        } else {
            $cookie_for_login = $_COOKIE['remember_me'] ?? false;

            $login_data = Login::getLoginFromCookie($cookie_for_login);

            if (is_object($login_data) && strtotime($login_data->expires_at) > time()) {
                $_SESSION[Config::$member_type] = $login_data->user_id;


            }
        }
    }
*/
    public static function getCurrentAdmin()
    {
        if (isset($_SESSION['admin_id'])) {
            return User::findById($_SESSION['admin_id']);
        } 
    }

    public static function setLastPage()
    {
        $_SESSION['last_page'] = $_SERVER['REQUEST_URI'];
    }

    public static function getLastPage()
    {
        return $_SESSION['last_page'] ?? '/';
    }

}
