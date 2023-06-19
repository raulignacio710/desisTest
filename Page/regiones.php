<?php

require 'connection.php';

$db = pg_connect("host=$host port=5432 dbname=$dbname user=$user password=$password");
$result = pg_query($db,"SELECT nombre_region FROM regiones");
$regiones = array();
while ($row = pg_fetch_assoc($result)){
    $regiones[] = $row['nombre_region'];
};
header('Content-Type: application/json');
echo json_encode($regiones);

?>