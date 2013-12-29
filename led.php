<?php
//echo exec('pkill LEDLoop');
//echo exec('/var/www/LEDLoop "' . $_GET["msg"] . ' " > /dev/null &');
//echo exec('/var/www/LEDPrint "' . $_GET["msg"] . '"');

$fh = fopen('/var/www/ledmsg.txt', 'w') or die("can't open file");
fwrite($fh, $_GET["msg"]);
fclose($fh);

?>
