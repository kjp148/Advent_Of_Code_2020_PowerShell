class Passport
{
    [int]$BirthYear
    [int]$IssueYear
    [int]$ExpirationYear
    [int]$Height
    [bool]$HeightIsMetric
    [string]$HairColor
    [string]$EyeColor
    [long]$PassportID
    [long]$CountryID

    Passport ()
    {

    }

    Passport (
        [int]$BirthYear,
        [int]$IssueYear,
        [int]$ExpirationYear,
        [int]$Height,
        [bool]$HeightIsMetric,
        [string]$HairColor,
        [string]$EyeColor,
        [long]$PassportID,
        [long]$CountryID)
    {
        $this.BirthYear      = $BirthYear
        $this.IssueYear      = $IssueYear
        $this.ExpirationYear = $ExpirationYear
        $this.Height         = $Height
        $this.HeightIsMetric = $HeightIsMetric
        $this.HairColor      = $HairColor
        $this.EyeColor       = $EyeColor
        $this.PassportID     = $PassportID
        $this.CountryID      = $CountryID
    }

    [int]IsValid () # 0: Valid | 1: Invalid data | 2: Missing fields
    {
        # Check if any fields are missing from passport
        if (@($this.BirthYear, $this.IssueYear, $this.ExpirationYear, $this.Height, $this.HeightIsMetric, $this.HairColor, $this.EyeColor, $this.PassportID) -contains $null)
        {
            return 2 # Missing fields
        }

        if (
            ($this.BirthYear -lt 1920) -or ($this.BirthYear -gt 2002) -or
            ($this.IssueYear -lt 2010) -or ($this.IssueYear -gt 2020) -or
            ($this.ExpirationYear -lt 2020) -or ($this.ExpirationYear -gt 2030) -or
            ($this.HeightIsMetric -and (($this.Height -lt 150) -or ($this.Height -gt 193))) -or
            (!$this.HeightIsMetric -and (($this.Height -lt 59) -or ($this.Height -gt 76))) -or
            ($this.HairColor[0] -ne '#') -or ($this.HairColor -match "[g-z]") -or ($this.HairColor.Length -ne 7) -or
            (@("amb", "blu", "brn", "gry", "grn", "hzl", "oth") -notcontains $this.EyeColor) -or
            ($this.PassportID -notmatch "\d{9}") -or ($this.PassportID.Length -ne 9)
        )
        {
            return 1
        }

        return 0 # Valid
    }
}

# Put passports into an array of arrays
$SortedPassports = @()
$New = $true
foreach ($Line in (Get-Content .\Input\day4.txt))
{
    if ($New)
    {
        $SortedPassports += (, $Line.Split(' '))

        $New = $false
    }
    elseif ($Line -eq "")
    {
        $New = $true # Blank line, next is new passport
        
    }
    else
    {
        $SortedPassports[-1] += $Line.Split(' ') # Add passport information to last index of array
    }
}

$Passports = @()
$Fields = @(("byr", "BirthYear"), ("iyr", "IssueYear"), ("eyr", "ExpirationYear"), ("hgt", "Height"), ("hcl", "HairColor"), ("ecl", "EyeColor"), ("pid", "PassportID"))
foreach ($Passport in $SortedPassports)
{
    $TempPassport = [Passport]::new()

    foreach ($Field in $Fields) # Loop through each passport field
    {
        if ($Passport -match "$($Field[0]):*") # Check if field exists
        {
            if ($Field[1] -eq "Height")
            {
                $HeightMatch = ($Passport -match "$($Field[0]):*")
                $TempPassport.Height = ($HeightMatch[0].Substring(4, $HeightMatch[0].Length - 4 - 2))
                $TempPassport.HeightIsMetric = ($HeightMatch[0].Substring($HeightMatch[0].Length - 2))
            }
            else
            {
                $TempPassport."$($Field[1])" = (($Passport -match "$($Field[0]):*")[0].Substring(4))
            }
        }
    }

    $Passports += $TempPassport
}

Write-Host "Day 4 Part 1: $($ValidPassports.count)"