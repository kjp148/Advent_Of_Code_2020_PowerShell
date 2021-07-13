$Passports = @()
$New = $true
$SearchConditions = ("byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid") # Leaving out cid

foreach ($Line in (Get-Content .\Input\day4.txt))
{
    if ($New)
    {
        $Passports += $Line # Last line was blank, new passport
        $New = $false
    }
    elseif ($Line -eq "")
    {
        $New = $true # Blank line, next is new passport
    }
    else
    {
        $Passports[-1] += " $($Line)" # Add passport information to last index of array
    }
}

$ValidPassports = @()
foreach ($Passport in $Passports)
{
    $Valid = $true
    foreach ($Condition in $SearchConditions)
    {
        if (!($Passport -match $Condition))
        {
            $Valid = $false
        }
    }
    
    if ($Valid)
    {
        $ValidPassports += $Passport
    }
}

Write-Host "Day 4 Part 1: $($ValidPassports.count)"