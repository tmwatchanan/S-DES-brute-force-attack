# Go to the specific directory
cd "C:\Users\Watchanan\OneDrive - Chiang Mai University\Computer Engineering\Academic Year 2560, 1st Semester\261447 Network and Information Security (3)\Assignments\hw2"

# Read ciphertext from file
$ciphertext = Get-Content ciphertext.txt -First 1
$ciphertext = $ciphertext.TrimEnd(',')
"ciphertext = {0}" -f $ciphertext

$studentCode = '570610601'
$numStudentCode = $studentCode.Length
$ciphertext_array = $ciphertext.Split(",")
$ciphertext_array = $ciphertext_array.TrimStart("0b")
$ciphertext_array = $ciphertext_array.PadLeft(8,'0')
$known_ciphertext = $ciphertext_array[0..($numStudentCode-1)]

"> starting brute force SDES  ........."

# Loop: Key
For ($key = 350; $key -lt 1024; $key += 1)
{
    $key_binary = [Convert]::ToString($key,2).PadLeft(10,'0')
    "key={0} [{1}]" -f $key, $key_binary
    $output = @(0) * $numStudentCode
    # Loop: Known first-9-characters ciphertext
    For ($i = 0; $i -lt $numStudentCode; $i += 1)
    {
        #"{0}" -f $known_ciphertext[$i]
        $output[$i] = .\Simplified-DES-master\sdes.exe decrypt $known_ciphertext[$i] $key_binary
        #"{0} -> {1}" -f $known_ciphertext[$i], $output[$i]
    }
    if (($output -join "") -match $studentCode)
    {
        "Found! key used for this cipertext is {0} [{1}]" -f $key, $key_binary
        $plaintext = @()
        ForEach ($block in $ciphertext_array)
        {
            $plaintext_block = .\Simplified-DES-master\sdes.exe decrypt $block $key_binary
            $plaintext += $plaintext_block
        }
        $plaintext = [string]$plaintext -replace ' ', ''
        $plaintext | out-file "plaintext.txt"
        "plaintext = {0}" -f $plaintext
        break
    }
}
