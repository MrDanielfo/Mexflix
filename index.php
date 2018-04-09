<?php
//session_start();
require_once('./controllers/Autoload.php');

$autoload = new AutoLoad();

$route = isset($_GET['r']) ? $_GET['r'] : 'home';

$mexflix = new Router($route);


//$a = new StatusModel();
