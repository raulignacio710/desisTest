<?php

require 'connection.php';
$db = pg_connect("host=$host port=5432 dbname=$dbname user=$user password=$password");
$nombre = $_POST['name'];
$alias = $_POST['alias'];
$rut = $_POST['rut'];
$email = $_POST['email'];
$region = $_POST['region'];
$comuna = $_POST['comuna'];
$candidato = $_POST['candidato'];
$metodo = $_POST['divulgacion'];
$metodoj = json_encode($metodo);
$result = pg_query($db,"INSERT INTO formulario_postulacion VALUES ('$nombre', '$alias', '$rut', '$email', '$region', '$comuna', '$candidato','$metodoj')");

if($result){
    $message = "Votacion enviada con exito!";
}
else{
    $error = pg_last_error($db);
    $message="Ha ocurrido un error: ".$error;
}
header('Content-Type: application/json');
echo json_encode($message);
?>