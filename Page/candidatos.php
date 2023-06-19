<?php

require 'connection.php';

$db = pg_connect("host=$host port=5432 dbname=$dbname user=$user password=$password");
$result = pg_query($db,"SELECT nombre_candidato FROM candidatos");
$candidatos = array();
while ($row = pg_fetch_assoc($result)){
    $candidatos[] = $row['nombre_candidato'];
};
header('Content-Type: application/json');
echo json_encode($candidatos);

?>