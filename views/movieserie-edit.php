<?php

$ms_controller = new MovieSeriesController();

if( $_POST['r'] == 'movieserie-edit' && $_SESSION['role'] == 'Admin' && !isset($_POST['crud']) ) {

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

     $movie = ($movieseries[0]['category'] == 'Movie' ) ? 'checked' : '';
     $serie = ($movieseries[0]['category'] == 'Serie' ) ? 'checked' : '';

     $status_controller = new StatusController();

     $status = $status_controller->get();

     $status_select = '';

     for($n = 0; $n < count($status); $n++) {
         $selected = ($movieseries[0]['status'] == $status[$n]['status']) ? 'selected' : '';
         $status_select .= '<option value="'. $status[$n]['status_id'] .'"'. $selected .'>'. $status[$n]['status'] .'</option>';
     }

      $template_ms = '
        <h2 class="p1">Editar Movieserie</h2>
        <form method="POST" class="item">
            <div class="p_25">
                <input type="text" placeholder="imdb_id" value="%s" disabled required>
                <input type="hidden" name="imdb_id" value="%s">
            </div>
            <div class="p_25">
                <input type="text" placeholder="title" name="title" value="%s" required>
            </div>
            <div class="p_25">
                <textarea name="plot" cols="22" rows="10" placeholder="descripcion">%s</textarea>
            </div>
            <div class="p_25">
                <input type="text" name="author" placeholder="autor" value="%s">
            </div>
            <div class="p_25">
                <input type="text" name="actors" placeholder="actores" value="%s">
            </div>
            <div class="p_25">
                <input type="text" placeholder="country" name="country" value="%s" required>
            </div>
            <div class="p_25">
                <input type="text" placeholder="premiere" name="premiere" value="%s" required>
            </div>
            <div class="p_25">
                <input type="url" name="poster" placeholder="póster" value="%s">
            </div>
            <div class="p_25">
                <input type="url" name="trailer" placeholder="tráiler" value="%s">
            </div>
            <div class="p_25">
                <input type="number" name="rating" placeholder="rating" value="%s" required>
            </div>
            <div class="p_25">
                <input type="text" placeholder="genres" name="genres" value="%s" required>
            </div>
            <div class="p_25">
                <select name="status" placeholder="status" required>
                  <option value="">status</option>
                  %s
                </select>
            </div>
            <div class="p_25">
                <input type="radio" name="category" id="movie" value="Movie" %s required>
                  <label for="movie">Movie</label>
                <input type="radio" name="category" id="serie" value="Serie" %s required>
                  <label for="serie">Serie</label>
            </div>
            <div class="p_25">
                <input class="button edit" type="submit" value="Editar">
                <input type="hidden" name="r" value="movieserie-edit">
                <input type="hidden" name="crud" value="set">
            </div>
        </form>
      ';

      printf(
          $template_ms,
          $movieseries[0]['imdb_id'],
          $movieseries[0]['imdb_id'],
          $movieseries[0]['title'],
          $movieseries[0]['plot'],
          $movieseries[0]['author'],
          $movieseries[0]['actors'],
          $movieseries[0]['country'],
          $movieseries[0]['premiere'],
          $movieseries[0]['poster'],
          $movieseries[0]['trailer'],
          $movieseries[0]['rating'],
          $movieseries[0]['genres'],
          $status_select,
          $movie,
          $serie
      );
   }


}else if( $_POST['r'] == 'movieserie-edit' && $_SESSION['role'] == 'Admin'
  && $_POST['crud'] == 'set' ) {


    $save_ms = array(
        'imdb_id' => $_POST['imdb_id'],
        'title' => $_POST['title'],
        'plot' => $_POST['plot'],
        'author' => $_POST['author'],
        'actors' => $_POST['actors'],
        'country' => $_POST['country'],
        'premiere' => $_POST['premiere'],
        'poster' => $_POST['poster'],
        'trailer' => $_POST['trailer'],
        'rating' => $_POST['rating'],
        'genres' => $_POST['genres'],
        'status' => $_POST['status'],
        'category' => $_POST['category']
    );

    $movieseries = $ms_controller->set($save_ms);

    $template = '<div class="container">
                    <p class="item  edit">Movieserie <b>%s</b> ha sido editado</p>
                </div>
                <script>
                    window.onload = function() {
                      reloadPage("movieseries")
                    }
                </script>
                ';

     printf($template, $_POST['title']);
} else {
   $controller = new ViewController();
   $controller->load_view('error401');
}
