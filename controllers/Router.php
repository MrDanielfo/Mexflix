<?php

class Router {
  public $route;

  public function __construct($route){

    $session_options = array(
        'use_only_cookies' => 1,
        'auto_start'   =>     1,
        'read_and_close' =>  true
    );

    if( !isset($_SESSION) )  session_start($session_options);

    if(!isset( $_SESSION['ok']))  $_SESSION['ok'] = false;


    if($_SESSION['ok']) {

      // toda la información de nuestra aplicación
      $this->route = isset($_GET['r']) ? $_GET['r'] : 'home';
      $controller = new ViewController();

      switch ($this->route) {
        case 'home':
          $controller->load_view('home');
          break;

        case 'movieseries':
          if( !isset( $_POST['r']) ) {
              $controller->load_view('movieseries');
          } else if( $_POST['r'] == 'movieserie-add' ) {
              $controller->load_view('movieserie-add');
          } else if( $_POST['r'] == 'movieserie-edit') {
              $controller->load_view('movieserie-edit');
          } else if( $_POST['r'] == 'movieserie-delete' ) {
              $controller->load_view('movieserie-delete');
          } else if( $_POST['r'] == 'movieserie-show' ) {
              $controller->load_view('movieserie-show');
          }
          break;

        case 'users':
          // tanto esta forma de utilizar el if, en users, como la de status son válidas
          if( !isset( $_POST['r']) ) {
              $controller->load_view('users');
          } else if( $_POST['r'] == 'user-add' ) {
              $controller->load_view('user-add');
          } else if( $_POST['r'] == 'user-edit' ) {
              $controller->load_view('user-edit');
          } else if( $_POST['r'] == 'user-delete' ) {
              $controller->load_view('user-delete');
          }
          break;

        case 'status':
        // incluso con un paréntesis después del == funcionan
        // ver status-edit
        if( !isset( $_POST['r']) ) {
            $controller->load_view('status');
        } else if( $_POST['r'] == 'status-add' ) {
            $controller->load_view('status-add');
        } else if( $_POST['r'] == ('status-edit') ) {
            $controller->load_view('status-edit');
        } else if( $_POST['r'] == 'status-delete' ) {
            $controller->load_view('status-delete');
        }
          break;

        case 'salir':
          $user_session = new SessionController();
          $user_session->logout();
          break;


        default:
          $controller->load_view('error404');
          break;
      }


    } else {
      if(!isset($_POST['user']) && !isset($_POST['pass']) ){
        // mostrar un formulario de autenticación
        $login_form = new ViewController();
        $login_form->load_view('login');
      }
      else {
            $user_session = new SessionController();
            $session = $user_session->login( $_POST['user'],  $_POST['pass'] );

            if( empty($session) ) {
              //echo 'El usuario y el password son incorrectos';
              $login_form = new ViewController();
              $login_form->load_view('login');
              //header('Location: ./?error=el usuario no existe');
              echo "<h3>El usuario " . $_POST[ 'user' ] . " , y el password " . $_POST['pass']  . " no coinciden con la base de datos, inténtalo de nuevo</h3>";
            } else {
              //echo 'El usuario y el password son correctos';
              //var_dump($session);

              $_SESSION['ok'] = true;

              foreach ($session as $row) {
                $_SESSION['user'] = $row['user'];
                $_SESSION['email'] = $row['email'];
                $_SESSION['name'] = $row['name'];
                $_SESSION['birthday'] = $row['birthday'];
                $_SESSION['pass'] = $row['pass'];
                $_SESSION['role'] = $row['role'];
              }

              header('Location: ./');
            }
      }

    }



  }
// fin del public construct

}
// fin de la clase
