$string_to_convert = 'Турбанова Дарья Игоревна'
$first_name = $string_to_convert.Split("")[1]
$middle_name = $string_to_convert.Split(" ")[2]
$surname = $string_to_convert.Split(" ")[0]

$Givenname = $first_name +' '+ $middle_name

$Givenname