<?php

namespace App\Controllers\Backoffice;

use App\Models\Category;
use App\Models\Helper;
use App\Models\Post;
use App\Modules\Auth;
use App\Modules\Flashmessage;
use App\Modules\Upload;
use \Core\View;

class Ajax extends \Core\Controller
{
    protected function before()
    {
        if (!Auth::getCurrentAdmin()) {
            $this->redirect('/ccb/admin/login');
        }
    }

    public function deleteSinglePostAction()
    {
        $content = trim(file_get_contents('php://input'));

        $decoded = json_decode($content, true);

        $response = $decoded['id'];
        if (Post::deleteOne($response)) {
            Flashmessage::set('El post ha sido eliminado', Flashmessage::SUCCESS);

            echo json_encode(true);
        } else {
            echo json_encode(false);

        }
    }

    public function deleteSingleCategoryAction()
    {
        $content = trim(file_get_contents('php://input'));

        $decoded = json_decode($content, true);

        $response = $decoded['id'];

        if (Category::deleteOne($response)) {
            Flashmessage::set('La categoría ha sido eliminada', Flashmessage::SUCCESS);
            echo json_encode(true);
        } else {
            echo json_encode(false);
        }

    }

    public function updateSingleCategoryAction()
    {
        $content = trim(file_get_contents('php://input'));

        $decoded = json_decode($content, true);

        $id = $decoded['id'];
        $name = $decoded['name'];

        if (trim($name) === '') {
            Flashmessage::set('El nombre de la categoría no puede estar vacío', Flashmessage::FAIL);
            echo json_encode('failed');
            exit;
        }

        if (strlen($name) > 255) {
            Flashmessage::set('El nombre de la categoría no puede contener más de 255 caracteres', Flashmessage::FAIL);
            echo json_encode('failed');
            exit;
        }

        foreach (Category::getAll() as $key => $value) {
            if ($value['name'] == $name) {
                Flashmessage::set('El nombre de la categoría ya existe', Flashmessage::FAIL);
                echo json_encode('failed');
                exit;
            }
        }

        if (Category::updateOne($id, $name)) {
            Flashmessage::set('La categoría ha sido actualizada', Flashmessage::SUCCESS);
            echo json_encode(true);
        } else {
            echo json_encode(false);
        }

    }

    public function imageGalleryAction()
    {
        $dir = $_SERVER['DOCUMENT_ROOT'] . '/public/images';
        $images = [];
        if (is_dir($dir)) {
            if ($dh = opendir($dir)) {
                while (($file = readdir($dh)) !== false) {
                    if ($file == '.' || $file == '..') {
                        continue;
                    }
                    $images[] = $file;
                }
                closedir($dh);
            }
        }
        echo json_encode($images);
    }
}
