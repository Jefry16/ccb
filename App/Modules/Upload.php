<?php

namespace App\Modules;


class Upload
{
  public static function singleImage()
  { 
    $error = 0;


    if(isset($_FILES['thumbnail']) && !$_FILES['thumbnail']['error']){
      
      if ($_FILES['thumbnail']['size'] > 1000000) {

        $error = ['El tamaño del archivo supera el limite'];

        return $error;
      }

      $mime_types = ['image/gif', 'image/png', 'image/jpeg'];


      $finfo = finfo_open(FILEINFO_MIME_TYPE);
      $mime_type = finfo_file($finfo, $_FILES['thumbnail']['tmp_name']);

      if ( ! in_array($mime_type, $mime_types)) {

          $error = ['Archivo invalido'];

          return $error;

      }

      $pathinfo = pathinfo($_FILES["thumbnail"]["name"]);
      $base = $pathinfo['filename'];

      $base = preg_replace('/[^a-zA-Z0-9_-]/', '_', $base);

      $base = mb_substr($base, 0, 200);

      $filename = $base . "." . $pathinfo['extension'];

      $destination = dirname($_SERVER['SERVER_NAME']). '/images/'. $filename;

      $i = 1;

        while (file_exists($destination)) {

            $filename = $base . "-$i." . $pathinfo['extension'];
            $destination = dirname($_SERVER['SERVER_NAME']). '/images/'. $filename;

            $i++;
        }

        if(move_uploaded_file($_FILES['thumbnail']['tmp_name'], $destination)){
          $error = $filename;

          return $error;

        } else {
          $error = ['No se pudo subir el archivo'];
          return $error;

        }
    }
    return $error;
  }
}
