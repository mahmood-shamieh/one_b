<?php
//header("dbtent-Type: application/json; charset=UTF-8");

require("../includes/conf.php");
// require ("../includes/send_notification.php");
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: *');

const SENDER_EMAIL_ADDRESS = 'no-reply@email.com';

function getAuthorizationHeader()
{
    $headers = null;
    if (isset($_SERVER['Authorization'])) {
        $headers = trim($_SERVER["Authorization"]);
    } else if (isset($_SERVER['HTTP_AUTHORIZATION'])) { //Nginx or fast CGI
        $headers = trim($_SERVER["HTTP_AUTHORIZATION"]);
    } elseif (function_exists('apache_request_headers')) {
        $requestHeaders = apache_request_headers();
        // Server-side fix for bug in old Android versions (a nice side-effect of this fix means we don't care about capitalization for Authorization)
        $requestHeaders = array_combine(array_map('ucwords', array_keys($requestHeaders)), array_values($requestHeaders));
        //print_r($requestHeaders);
        if (isset($requestHeaders['Authorization'])) {
            $headers = trim($requestHeaders['Authorization']);
        }
    }
    return $headers;
}
/**
 * get access token from header
 * */
function getBearerToken()
{
    $headers = getAuthorizationHeader();
    // HEADER: Get the access token from the header
    return $headers;
    if (!empty($headers)) {

        if (preg_match('/Bearer\s((.*)\.(.*)\.(.*))/', $headers, $matches)) {
            return $matches[1];
        }
    }
    return 'no';
}

function getPost()
{
    if (!empty($_POST)) {
        // when using application/x-www-form-urlencoded or multipart/form-data as the HTTP Content-Type in the request
        // NOTE: if this is the case and $_POST is empty, check the variables_order in php.ini! - it must contain the letter P
        return $_POST;
    }

    // when using application/json as the HTTP Content-Type in the request 
    $post = json_decode(file_get_contents('php://input'), true);
    if (json_last_error() == JSON_ERROR_NONE) {
        return $post;
    }

    return [];
}

function uploadimage($name, $imagepost)
{
    // if(isset($All_post["image1_image"])){
    $base64_string = $imagepost;
    // echo $base64_string;
    // die;
    $rand1 = rand(999, 99999999);
    $outputfile = "uploads/" . $name . $rand1 . ".jpg";
    //save as image.jpg in uploads/ folder

    $filehandler = fopen($outputfile, 'wb');
    //file open with "w" mode treat as text file
    //file open with "wb" mode treat as binary file

    fwrite($filehandler, base64_decode($base64_string));
    // we could add validation here with ensuring count($data)>1

    // clean up the file resource
    fclose($filehandler);
    return ($name . $rand1 . ".jpg");
    // }else{
    //     $status=false;
    //     $msg = "فشل تحميل الصورة";
    //     $http_response = 200;
    //     respond($http_response,$status,$msg,'','');
    //     die;
    // }
}


$All_post = getPost();




$user_id = $All_post['user_id'];
$subcat_id = $All_post['subcat_id'];
$type = $All_post['type'];
$bill = $All_post['bill'];
$http_response = 200;

$all_news = $db->select("SELECT * FROM `user` WHERE `id` = '" . $user_id . "' and `token` = '" . substr(getBearerToken(), 7) . "' and `active` = '1'");
if (count($all_news) == 0) {
    $status = false;
    $msg = "يرجى اعادة تسجيل الدخول";
    $http_response = 400;
    respond($http_response, $status, $msg, '', '');
    die;
} else {

    $subcat_name = $db->select("SELECT * from subcat where `id` = '" . $subcat_id . "' ");
    $subcat = $db->select("SELECT * from sub_cat_continant where `subcat_id` = '" . $subcat_id . "' ");
    $balances = $db->select("SELECT * from balances where `id` = '" . $subcat_name[0]['balances_id'] . "' ");
    $pay = ((int)$bill * $balances[0]['price'] / 100) + (int)$bill;
    // $cat =  $db->select("SELECT * from cat where `id` = '".$subcat_name[0]['cat_id']."' " );

    $column_name = [];
    $column_value = [];

    if ($type == 0) {
        if ($all_news[0]['balance'] == 0) {
            $status = false;
            $msg = "لا يمكنك الاستعلام ، الرجاء شحن الرصيد";

            $http_response = 200;

            $title = 'تم الغاء الطلب';
            send_notification($user_id, $title, $msg, $db);
            respond($http_response, $status, $msg, '', '');

            die;
        }
        $sets = " subcat_id='" . $subcat_id . "',type = '0', bill = '0', user_id = '" . $user_id . "',";
    }
    if ($type == 1 || $type == 3) {
        $sets = " subcat_id='" . $subcat_id . "',type = '" . $type . "', bill = '" . $bill . "', pay = '" . $pay . "', user_id = '" . $user_id . "',";
    }

    $level = $db->select('select * from user_prev where level_id = ' . $all_news[0]['user_level'] . ' and subcat_id = ' . $subcat_id);
    $admins = $db->select("select * from admin where admin_level IN (select level_id from admin_prev where subcat_id = '" . $subcat_id . "')");

    $inputs = array();
    $bills = array();
    $lists = [];
    $new_list = [];
    $benefits = array();
    $cost = array();
    $cost = 0;

    for ($i = 0; $i < count($subcat); $i++) {
        if ($subcat[$i]['type'] == 'text' || $subcat[$i]['type'] == 'dropdown_bill' || $subcat[$i]['type'] == 'dropdown') {
            $column_name[$i] = $subcat[$i]['name'];
            $column_value[$i] = $All_post[$subcat[$i]['name']];

            $inputs[$column_name[$i]] = $column_value[$i];
        }

        if ($subcat[$i]['type'] == 'image') {
            $column_name[$i] = $subcat[$i]['name'];
            $column_value[$i] = $All_post[$subcat[$i]['name'] . '_image'];

            if (file_exists("uploads/" . $All_post[$subcat[$i]['name']]) == 1) {
                $inputs[$column_name[$i]] = $All_post[$subcat[$i]['name']];
            } else {
                $inputs[$column_name[$i]] = uploadimage($subcat_name[0]['name'] . '_' . $subcat[$i]['name'] . '_', $column_value[$i]);
            }
        } elseif ($subcat[$i]['type'] == 'list') {

            $column_name[$i] = $subcat[$i]['name'];
            $column_value[$i] = array();
            $column_value[$i] = $All_post[$subcat[$i]['name']];
            $bills[$i] = $All_post['bill'];
            if ($type == 0) {
                $bills[$i] == NULL;
            }

            flat($column_value, $result);

            flat($bills[$i], $r);
            flat($benefits[$i], $b);
            for ($j = 0; $j < count($result); $j++) {

                foreach ($subcat as $t) {
                    $inputs[$t['name']] = $result[$j];
                }
                // echo $r[$j];

                if ($type == 0) {

                    $lists[$j] = " subcat_id='" . $subcat_id . "',type = '" . $type . "', bill = '0',cost='0', user_id = '" . $user_id . "',";
                    // $lists[$j] = $lists[$j] . $column_name[$i] . " = '" . $result[$j] . "',";
                    $lists[$j] = $lists[$j] . "inputs = '" .   json_encode($inputs, JSON_UNESCAPED_UNICODE) . "',";
                }

                if ($type == 1) {
                    $pay = ((int)$r[$j] * $balances[0]['price'] / 100) + (int)$r[$j];
                    $lists[$j] = " subcat_id='" . $subcat_id . "',type = '" . $type . "', bill = '" . (int)$r[$j] . "', pay = '" . $pay . "' , cost='" . ((int)$r[$j] + ((int)$r[$j] * (int)$level[0]['price'] / 100)) . "', user_id = '" . $user_id . "',";
                    // $lists[$j] = $lists[$j] . $column_name[$i] . " = '" . $result[$j] . "',";
                    $lists[$j] = $lists[$j] . "inputs = '" .   json_encode($inputs, JSON_UNESCAPED_UNICODE) . "',";
                }

                if ($type == 3) {
                    $pay = ((int)$r[$j] * $balances[0]['price'] / 100) + (int)$r[$j];
                    $lists[$j] = " subcat_id='" . $subcat_id . "',type = '" . $type . "', bill = '" . (int)$r[$j] . "', pay = '" . $pay . "', cost='" . ((int)$r[$j] - ((int)$r[$j] * (int)$level[0]['price'] / 100)) . "', user_id = '" . $user_id . "',";
                    // $lists[$j] = $lists[$j] . $column_name[$i] . " = '" . $result[$j] . "',";
                    $lists[$j] = $lists[$j] . "inputs = '" .   json_encode($inputs, JSON_UNESCAPED_UNICODE) . "',";
                }
            }
        }
    }


    if (count($lists) == 0) {

        $benefits = 0;
        $cost = 0;
        $benefits = (int)$bill * $level[0]['price'] / 100;
        if ($type == 0 || $type == 1) {
            $cost = (int)$bill + $benefits;

            if (($all_news[0]['balance'] >= $cost)) {
                if ($balances[0]['balance'] >= $bill) {

                    $sets =  $sets . "inputs = '" .   json_encode($inputs, JSON_UNESCAPED_UNICODE) . "',";

                    if ($type == 0) {
                        $sets = $sets . "cost = '0',";
                    } else {
                        $sets = $sets . "cost = '" . $cost . "',";
                    }

                    $sets = rtrim($sets, ",");
                    // $types = $db->select('select * from sub_cat_continant where subcat_id = ' . $db->sqlsafe($_POST['subcat_id']));
                    //      echo $sets;
                    //   die;
                    $order = mysqli_query($con, "INSERT into orders set " . $sets . " ");
                    $id = mysqli_insert_id($con);

                    date_default_timezone_set('Syria/Damascus');
                    $date = date('Y-m-d h:i:s', time());
                    $note_number =  $order;
                    $user = ' ' . $all_news[0]['first_name'] . ' ' . $all_news[0]['last_name'];
                    if ($type == 0) {
                        $type = 'استعلام';
                        $page = 'requests';
                    } else {
                        $type = 'دفع';
                        $page = 'sales';
                    }
                    $note = ' تم ادخال طلب ' . $type . ' جديد من قبل المستخدم' . $user;
                    for ($j = 0; $j < count($admins); $j++) {
                        $notify =  mysqli_query($con, "INSERT into notifications set time='" . $date . "',note= '" . $note . "',subcat_id='" . $All_post['subcat_id'] . "',adminid='" . $admins[$j]['id'] . "',order_id='" . $id . "',url='index.php?m=" . $page . "&a=view&company=0&subcat_id=" . $All_post['subcat_id'] . "' ");
                    }


                    $status = true;
                    $msg = "طلبك قيد المعالجة";
                    $http_response = 200;

                    $title = ' تمت ارسال الطلب  ';
                    send_notification($user_id, $title, $msg, $db);
                    respond($http_response, $status, $msg, '', '');

                    die;
                } else {

                    $sets =  $sets . "inputs = '" .   json_encode($inputs, JSON_UNESCAPED_UNICODE) . "',";
                    $sets = $sets . "cost = '" . $cost . "',";
                    $sets = $sets . "result = ' خطأ في الخادم',";
                    $sets = $sets . "finished = '3',";
                    $sets = rtrim($sets, ",");

                    $order = mysqli_query($con, "INSERT into orders set " . $sets . " ");
                    $id = mysqli_insert_id($con);

                    date_default_timezone_set('Syria/Damascus');
                    $date = date('Y-m-d h:i:s', time());
                    $note_number =  $order;
                    $user = ' ' . $all_news[0]['first_name'] . ' ' . $all_news[0]['last_name'];
                    if ($type == 0) {
                        $type = 'استعلام';
                        $page = 'requests';
                    } else {
                        $type = 'دفع';
                        $page = 'sales';
                    }
                    $note = ' تم ادخال طلب ' . $type . ' جديد من قبل المستخدم' . $user;
                    for ($j = 0; $j < count($admins); $j++) {
                        $notify =  mysqli_query($con, "INSERT into notifications set time='" . $date . "',note= '" . $note . "',subcat_id='" . $All_post['subcat_id'] . "',adminid='" . $admins[$j]['id'] . "',order_id='" . $id . "',url='index.php?m=" . $page . "&a=view&company=0&subcat_id=" . $All_post['subcat_id'] . "' ");
                    }
                    $status = false;
                    $msg = " خطأ في الخادم ";
                    $http_response = 200;

                    $title = ' تم الغاء الطلب  ';
                    send_notification($user_id, $title, $msg, $db);
                    respond($http_response, $status, $msg, '', '');

                    die;
                }
            } else {

                $sets =  $sets . "inputs = '" .   json_encode($inputs, JSON_UNESCAPED_UNICODE) . "',";
                $sets = $sets . "cost = '" . $cost . "',";
                $sets = $sets . "result = 'الطلب ملغى لعدم توفر رصيد كافٍ',";
                $sets = $sets . "finished = '3',";
                $sets = rtrim($sets, ",");

                $order = mysqli_query($con, "INSERT into orders set " . $sets . " ");
                $id = mysqli_insert_id($con);

                date_default_timezone_set('Syria/Damascus');
                $date = date('Y-m-d h:i:s', time());
                $note_number =  $order;
                $user = ' ' . $all_news[0]['first_name'] . ' ' . $all_news[0]['last_name'];
                if ($type == 0) {
                    $type = 'استعلام';
                    $page = 'requests';
                } else {
                    $type = 'دفع';
                    $page = 'sales';
                }
                $note = ' تم ادخال طلب ' . $type . ' جديد من قبل المستخدم' . $user;
                for ($j = 0; $j < count($admins); $j++) {
                    $notify =  mysqli_query($con, "INSERT into notifications set time='" . $date . "',note= '" . $note . "',subcat_id='" . $All_post['subcat_id'] . "',adminid='" . $admins[$j]['id'] . "',order_id='" . $id . "',url='index.php?m=" . $page . "&a=view&company=0&subcat_id=" . $All_post['subcat_id'] . "' ");
                }
                $status = false;
                $msg = "طلبك ملغى لعدم توفر رصيد كافٍ";
                $http_response = 200;

                $title = 'تم الغاء الطلب';
                send_notification($user_id, $title, $msg, $db);
                respond($http_response, $status, $msg, '', '');

                die;
            }
        }

        if ($type == 3) {
            $cost = (int)$bill - $benefits;
            $sets =  $sets . "inputs = '" .   json_encode($inputs, JSON_UNESCAPED_UNICODE) . "',";

            $sets = $sets . "cost = '" . $cost . "',";

            $sets = rtrim($sets, ",");
            //  echo $sets;
            //  die;
            $order = mysqli_query($con, "INSERT into orders set " . $sets . " ");
            $id = mysqli_insert_id($con);

            date_default_timezone_set('Syria/Damascus');
            $date = date('Y-m-d h:i:s', time());
            $note_number =  $order;
            $user = ' ' . $all_news[0]['first_name'] . ' ' . $all_news[0]['last_name'];

            $nottype = 'شحن';
            $page = 'bank';

            $note = ' تم ادخال طلب ' . $nottype . ' جديد من قبل المستخدم' . $user;
            for ($j = 0; $j < count($admins); $j++) {
                $notify =  mysqli_query($con, "INSERT into notifications set time='" . $date . "',note= '" . $note . "',subcat_id='" . $All_post['subcat_id'] . "',adminid='" . $admins[$j]['id'] . "',order_id='" . $id . "',url='index.php?m=" . $page . "&a=view&company=0&subcat_id=" . $All_post['subcat_id'] . "' ");
            }
            $status = true;
            $msg = "طلبك قيد المعالجة";
            $http_response = 200;

            $title = ' تم ارسال  الطلب  ';
            send_notification($user_id, $title, $msg, $db);
            respond($http_response, $status, $msg, '', '');


            die;
        }
    } else {

        if ($type == 0) {
            $cost_all = 0;
        } else {
            $rr = [];
            for ($j = 0; $j < count($result); $j++) {
                $rr = (int)$r[$j];
                $cost_all += (int)$r[$j] + ($rr * (int)$level[0]['price'] / 100);
            }
        }

        if (($all_news[0]['balance'] > $cost_all) || ($all_news[0]['balance'] == $cost_all)) {

            if ($balances[0]['balance'] > $rr) {

                for ($i = 0; $i < count($lists); $i++) {

                    $lists[$i] = rtrim($lists[$i], ",");
                    // echo $lists[$i];
                    // die;
                    $order = mysqli_query($con, "INSERT into orders set " . $lists[$i] . " ");

                    $id = mysqli_insert_id($con);

                    date_default_timezone_set('Syria/Damascus');
                    $date = date('Y-m-d h:i:s', time());
                    $note_number =  $order;
                    $user = ' ' . $all_news[0]['first_name'] . ' ' . $all_news[0]['last_name'];
                    if ($type == 0) {
                        $type = 'استعلام';
                        $page = 'requests';
                    } else {
                        $type = 'دفع';
                        $page = 'sales';
                    }
                    $note = ' تم ادخال طلب ' . $type . ' جديد من قبل المستخدم' . $user;
                    for ($j = 0; $j < count($admins); $j++) {
                        $notify =  mysqli_query($con, "INSERT into notifications set time='" . $date . "',note= '" . $note . "',subcat_id='" . $All_post['subcat_id'] . "',adminid='" . $admins[$j]['id'] . "',order_id='" . $id . "',url='index.php?m=" . $page . "&a=view&company=0&subcat_id=" . $All_post['subcat_id'] . "' ");
                    }
                }

                $status = true;
                $msg = "طلبك قيد المعالجة";
                $http_response = 200;

                $title = ' تمت ارسال الطلب';
                send_notification($user_id, $title, $msg, $db);
                respond($http_response, $status, $msg, '', '');

                die;
            } else {
                for ($i = 0; $i < count($lists); $i++) {

                    $lists[$i] = $lists[$i] . "result = 'خطأ في الخادم ',";
                    $lists[$i] = $lists[$i] . "finished = '3',";
                    $lists[$i] = rtrim($lists[$i], ",");
                    $order = mysqli_query($con, "INSERT into orders set " . $lists[$i] . " ");
                    $id = mysqli_insert_id($con);

                    date_default_timezone_set('Syria/Damascus');
                    $date = date('Y-m-d h:i:s', time());
                    $note_number =  $order;
                    $user = ' ' . $all_news[0]['first_name'] . ' ' . $all_news[0]['last_name'];
                    if ($type == 0) {
                        $type = 'استعلام';
                        $page = 'requests';
                    } else {
                        $type = 'دفع';
                        $page = 'sales';
                    }
                    $note = ' تم ادخال طلب ' . $type . ' جديد من قبل المستخدم' . $user;
                    for ($j = 0; $j < count($admins); $j++) {
                        $notify =  mysqli_query($con, "INSERT into notifications set time='" . $date . "',note= '" . $note . "',subcat_id='" . $All_post['subcat_id'] . "',adminid='" . $admins[$j]['id'] . "',order_id='" . $id . "',url='index.php?m=" . $page . "&a=view&company=0&subcat_id=" . $All_post['subcat_id'] . "' ");
                    }
                }
                $status = true;
                $msg = " خطأ في الخادم";
                $http_response = 200;

                $title = ' تم الغاء الطلب  ';
                send_notification($user_id, $title, $msg, $db);
                respond($http_response, $status, $msg, '', '');

                die;
            }
        } else {

            for ($i = 0; $i < count($lists); $i++) {
                $lists[$i] = $lists[$i] . "result = 'الطلب ملغى لعدم توفر رصيد كافٍ',";
                $lists[$i] = $lists[$i] . "finished = '3',";
                $lists[$i] = rtrim($lists[$i], ",");
                $order = mysqli_query($con, "INSERT into orders set " . $lists[$i] . " ");
                $id = mysqli_insert_id($con);

                date_default_timezone_set('Syria/Damascus');
                $date = date('Y-m-d h:i:s', time());
                $note_number =  $order;
                $user = ' ' . $all_news[0]['first_name'] . ' ' . $all_news[0]['last_name'];
                if ($type == 0) {
                    $type = 'استعلام';
                    $page = 'requests';
                } else {
                    $type = 'دفع';
                    $page = 'sales';
                }
                $note = ' تم ادخال طلب ' . $type . ' جديد من قبل المستخدم' . $user;
                for ($j = 0; $j < count($admins); $j++) {
                    $notify =  mysqli_query($con, "INSERT into notifications set time='" . $date . "',note= '" . $note . "',subcat_id='" . $All_post['subcat_id'] . "',adminid='" . $admins[$j]['id'] . "',order_id='" . $id . "',url='index.php?m=" . $page . "&a=view&company=0&subcat_id=" . $All_post['subcat_id'] . "' ");
                }
            }
            $status = true;
            $msg = "طلبك ملغى لعدم توفر رصيد كافٍ";
            $http_response = 200;

            $title = 'تم الغاء الطلب';
            send_notification($user_id, $title, $msg, $db);
            respond($http_response, $status, $msg, '', '');


            die;
        }
    }
}



function flat($array, &$return)
{
    if (is_array($array)) {
        array_walk_recursive($array, function ($a) use (&$return) {
            flat($a, $return);
        });
    } else if (is_string($array) && stripos($array, '[') !== false) {
        $array = explode(',', trim($array, "[]"));
        flat($array, $return);
    } else {
        $return[] = $array;
    }
}

function respond($http_response, $status, $msg, $token, $data)
{
    if ($http_response == 200) {
        $result_arr = array();
        $status_msg = array(
            "status" => $status,
            "msg" => $msg,
            "token" => $token,
            "data" => $data
        );
        array_push($result_arr, $status_msg);
        http_response_code(200);
        echo json_encode($status_msg, JSON_UNESCAPED_UNICODE);

        die;
    }
    if ($http_response == 400) {
        $result_arr = array();
        $status_msg = array(
            "status" => $status,
            "msg" => $msg

        );

        array_push($result_arr, $status_msg);
        http_response_code(400);
        echo json_encode($status_msg, JSON_UNESCAPED_UNICODE);

        die;
    }
}

function send_notification($user_id, $title, $msg, $db)
{
    $user = $db->select('select * from user where id = ' . $user_id);
    $token = $user[0]['FCM_token'];
    $fcm_array = $db->select('select * from site_conf where id=1');
    $body = $msg;
    $fcmUrl = 'https://fcm.googleapis.com/fcm/send';
    $data = [
        'title' => $title,
        'body' => $body,
    ];
    $iosalert = [
        'title' => $title,
        'body' => $body,
        'sound' => "default"
    ];
    $m = [
        'to' => $token,
        'notification' => $iosalert,
        'priority' => 10,
        'data' => $data
    ];

    $headers = [
        'Authorization: key=' . $fcm_array[0]["fcm_key"] . '',
        'Content-Type: application/json;charset=UTF-8'
    ];
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $fcmUrl);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($m));
    $result = curl_exec($ch);
    curl_close($ch);
    // $msg = $result;



    date_default_timezone_set('Syria/Damascus');
    $date = date('Y-m-d h:i:s', time());
    $in_arr = array(
        'text' => $db->sqlsafe($msg),
        'user_id' => $db->sqlsafe($user_id),
        'date' => $db->sqlsafe($date),
        'admin_id' => $db->sqlsafe(6)
    );
    $db->insert('user_not', $in_arr);
}

	




//if ($stmt == ''){
//	return;
//};

//$stmt->execute();
//$result = $stmt->get_result();
//$outp = $result->fetch_all(MYSQLI_ASSOC);

//echo json_encode($outp , JSON_UNESCAPED_UNICODE);
