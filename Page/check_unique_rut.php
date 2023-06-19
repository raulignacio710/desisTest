<?php

require 'connection.php';
$rut = $_GET['rut'];
$db = pg_connect("host=$host port=5432 dbname=$dbname user=$user password=$password");
$result = pg_query($db,"SELECT count(*) FROM formulario_postulacion fp WHERE fp.rut='$rut'");
$row = pg_fetch_row($result);
if($row[0]>0){
    $rut_exist = array(true);
}else{
    $rut_exist = array(false);
}
echo json_encode($rut_exist);

?>