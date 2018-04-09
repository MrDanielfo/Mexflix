<?php

$ms_controller = new MovieSeriesController();

if( $_POST['r'] == 'movieserie-delete' && $_SESSION['role'] == 'Admin' && !isset($_POST['crud']) ) {

  $movieseries = $ms_controller->get($_POST['imdb_id']);

  if( empty($movieseries) ) {
    $template = '<div class="container">
                    <p class="item  error">No existe la movieserie número <b>%s</b></p>
                </div>
                <script>
                    window.onload = function() {
                      reloadPage("movieseries")
                    }
                </script>
                ';
   printf($template, $_POST['imdb_id']);
   } else {
      $template_ms = '
        <h2 class="p1">Eliminar Movieserie</h2>
        <form method="POST" class="item">
            <div class="p1 f2">
              ¿Estás seguro que quieres eliminar la movieserie: <mark class="p1">%s</mark>?
            </div>
            <div class="p_25">
                <input class="button  delete" type="submit" value="SI">
                <input class="button  add" type="button" value="NO" onclick="history.back()">
                <input type="hidden" name="imdb_id" value="%s">
                <input type="hidden" name="r" value="movieserie-delete">
                <input type="hidden" name="crud" value="del">
            </div>
        </form>
      ';

      printf(
          $template_ms,
          $movieseries[0]['title'],
          $movieseries[0]['imdb_id']
      );
   }


}else if( $_POST['r'] == 'movieserie-delete' && $_SESSION['role'] == 'Admin'
  && $_POST['crud'] == 'del' ) {

    $del_ms = $_POST['imdb_id'];

    $movieseries = $ms_controller->del($del_ms);

    $template = '<div class="container">
                    <p class="item  delete">Movieserie <b>%s</b> ha sido eliminada</p>
                </div>
                <script>
                    window.onload = function() {
                      reloadPage("movieseries")
                    }
                </script>
                ';

     printf($template, $_POST['imdb_id']);
} else {
   $controller = new ViewController();
   $controller->load_view('error401');
}
