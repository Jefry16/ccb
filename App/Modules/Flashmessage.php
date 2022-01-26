<?php

namespace App\Modules;

use App\Models\User;

/**
 * Ajax controller
 *
 * PHP version 7.0
 */
class Flashmessage 
{
    const SUCCESS = "success";
    const INFO = 'warning';
    const FAIL = 'danger';

    public static function set($message, $type ="success") 
    {
        if ( !isset($_SESSION['flash_notification']) ) {
            $_SESSION['flash_notification'] = [];
        }
        $_SESSION['flash_notification'][] = [
            'message' => $message,
            'type' => $type
        ];
    }

    public static function get()
    {
        if(isset($_SESSION['flash_notification'])) {
            $message = $_SESSION['flash_notification'];
            unset($_SESSION['flash_notification']);
            return $message;
        }
    }
}