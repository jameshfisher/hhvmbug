<?php

$keys = array_keys($_SERVER);

sort($keys);

foreach ($keys as $key) {
  echo $key . "\n";
}
