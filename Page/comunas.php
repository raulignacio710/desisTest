<?php

require 'connection.php';
$id = $_GET['id'];
$db = pg_connect("host=$host port=5432 dbname=$dbname user=$user password=$password");
$result = pg_query($db,"SELECT nombre_comuna FROM comunas WHERE id_region=$id");
$comunas = array();
if(!$result){
    echo 'error';
    exit;
}
while ($row = pg_fetch_assoc($result)){
    $comunas[] = $row['nombre_comuna'];
};
header('Content-Type: application/json');
echo json_encode($comunas);

?>