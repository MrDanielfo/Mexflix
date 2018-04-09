<?php
print('<h2>Movieseries</h2>');

$ms_controller = new MovieSeriesController();

$movieseries = $ms_controller->get();

if(empty($movieseries)) {
  print('
    <div class="container">
        <p class="item  error">No hay Movieseries</p>
    </div>
  ');
} else {
  $template_ms = '
    <div class="item">
        <table>
          <tr>
            <th>IMDB Id</th>
            <th>Título</th>
            <th>Estreno</th>
            <th>Géneros</th>
            <th>Status</th>
            <th>Categoría</th>
            <th colspan="3">
              <form method="POST">
                  <input type="hidden" name="r" value="movieserie-add">
                  <input class="button add" type="submit" value="Agregar">
              </form>
            </th>
          </tr>';
      for ($n= 0; $n < count($movieseries); $n++) {
        $template_ms .=
        '<tr>
          <td>'. $movieseries[$n]['imdb_id'] .'</td>
          <td>'. $movieseries[$n]['title'] .'</td>
          <td>'. $movieseries[$n]['premiere'] .'</td>
          <td>'. $movieseries[$n]['genres'] .'</td>
          <td>'. $movieseries[$n]['status'] .'</td>
          <td>'. $movieseries[$n]['category'] .'</td>
          <td>
            <form method="POST">
                <input type="hidden" name="r" value="movieserie-show">
                <input type="hidden" name="imdb_id" value="'. $movieseries[$n]['imdb_id'] .'">
                <input class="button show" type="submit" value="Mostrar">
            </form>
          <td>
            <form method="POST">
                <input type="hidden" name="r" value="movieserie-edit">
                <input type="hidden" name="imdb_id" value="'. $movieseries[$n]['imdb_id'] .'">
                <input class="button edit" type="submit" value="Editar">
            </form>
          </td>
          <td>
            <form method="POST">
                <input type="hidden" name="r" value="movieserie-delete">
                <input type="hidden" name="imdb_id" value="'. $movieseries[$n]['imdb_id'] .'">
                <input class="button delete" type="submit" value="Eliminar">
            </form>
          </td>
        </tr>';
      }
    $template_ms .= '
        </table>
    </div>
  ';

  print($template_ms);
}
