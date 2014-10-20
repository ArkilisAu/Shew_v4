<?php

include_once("connect.php");

# Test
$sql_test="select * from activity";
$res= mysql_query($sql_test, getConnected());
while($row=mysql_fetch_array($res, MYSQL_ASSOC))
{
    print_r($row);
}


$des        =$_POST['activity_name']; # description is the ['SENT,'RECV]
$latitude   =$_POST['latitude'];
$longitude  =$_POST['longitude'];
$user_id    =$_POST['user_id'];  

date_default_timezone_set('Australia/Brisbane');
$date = date('m/d/Y h:i:s a', time());

# insert into activity table
$sql_cmd= "insert into activity (userid, datetime, descriptioni, latitude, longitude, fileurl) values ";
$sql_cmd.="($user_id,";
$sql_cmd.="$datetime, ";
$sql_cmd.="$des, ";
$sql_cmd.="$latitude, ";
$sql_cmd.="$longitude, ";



?>
