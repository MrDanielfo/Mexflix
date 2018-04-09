<?php
 if($_POST['r'] == 'movieserie-show' && isset($_POST['imdb_id']) ) {

   $ms_controller = new MovieSeriesController();
   $movieseries = $ms_controller->get($_POST['imdb_id']);

   if( empty($movieseries) ) {
      printf('
        <div class="container">
          <p class="item error">Error al cargar la información de la MovieSeries <b>%s</b></p>
        </div>
      ', $_POST['imdb']);
   } else {
      $template_ms = '
        <div class="item  movieserie-info">
          <h2 class="p_5">%s</h2>
          <p class="p_5">%s</p>
          <p class="p_5">
            <small class="block">( %s )</small>
            <small class="block">%s</small>
            <small class="block">%s</small>
            <small class="block">%s</small>
            <small class="block">%s</small>
            <small class="block">%s</small>
          </p>
          <img src="%s" alt="" class="p_5  poster">
          <p class="p_5">Author: <b>%s</b></p>
          <p class="p_5">Actors: <b>%s</b></p>
          <article class="p_5  ph7  mauto  left">%s</article>
          <div class="p_5  trailer">
            <iframe src="%s" frameborder="0" allowfullscren></iframe>
          </div>
          <input type="button" class="p_5  button  add" value="Regresar" onclick="history.back()">
        </div>
      ';

      $trailer = str_replace('watch?v=', 'embed/', $movieseries[0]['trailer']);

      printf(
             $template_ms,
             $movieseries[0]['title'],
             $movieseries[0]['genres'],
             $movieseries[0]['imdb_id'],
             $movieseries[0]['status'],
             $movieseries[0]['category'],
             $movieseries[0]['country'],
             $movieseries[0]['premiere'],
             $movieseries[0]['rating'],
             $movieseries[0]['poster'],
             $movieseries[0]['author'],
             $movieseries[0]['actors'],
             $movieseries[0]['plot'],
             $trailer
           );
   }

 } else {
   $controller = new ViewController();
   $controller->load_view('error404');
 }
