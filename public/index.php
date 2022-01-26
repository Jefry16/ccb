<?php

/**
 * Front controller
 *
 * PHP version 7.0
 */

/**
 * Composer
 */
require dirname(__DIR__) . '/vendor/autoload.php';


/**
 * Error and Exception handling
 */
error_reporting(E_ALL);
set_error_handler('Core\Error::errorHandler');
set_exception_handler('Core\Error::exceptionHandler');
session_start();

/**
 * Routing
 */
$router = new Core\Router();

// specifics routes

$router->add('ccb/admin/login', ['controller' => 'Login', 'action' => 'index', 'namespace' => 'Backoffice']);
$router->add('ccb/admin', ['controller' => 'Admin', 'action' => 'index', 'namespace' => 'Backoffice']);

$router->add('ccb/admin/{controller}/{action}', ['namespace' => 'Backoffice']);



//frontend routes


//backoffice routes

    
$router->dispatch($_SERVER['QUERY_STRING']);
