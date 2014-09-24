"{0}" -f 0
"{0}" -f 1
"{0}" -f 2
"{1}" -f 0
"{1}" -f 1
"{1}" -f 2



'Length: ' + $args.Length

for ($i = 0; $i -lt $args.Length; ++$i)
{
    "[{0}]: {1}" -f $i, $args[$i]
}
