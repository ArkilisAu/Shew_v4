<?php

$username="root";
$password="wahaha1988";
$host="localhost";
$dbname="fileSharing";

# return connection object
function getConnected()
{
    global $username;
    global $password;
    global $host;
    global $dbname;

    echo("host: $host");
    $conn= @mysql_connect($host, $username, $password) or die("Could not connect!");
    $res= @mysql_select_db($dbname, $conn) or die("Could not select database!");
    return $conn;
}

?>
