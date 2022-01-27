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

        echo json_encode(Post::deleteOne($response));
    }
}
