class Instruction
{
    [int]$Min
    [int]$Max
    [char]$Character
    [string]$Password

    Instruction ([int]$Min, [int]$Max, [char]$Character, [string]$Password)
    {
        $this.Min       = $Min
        $this.Max       = $Max
        $this.Character = $Character
        $this.Password  = $Password
    }
}

$Instructions = @()

Get-Content .\Input\day2.txt | ForEach-Object {
    $Instructions += [Instruction]::new(
        $_.Substring(0, $_.IndexOf('-')),
        $_.Substring($_.IndexOf('-') + 1, $_.IndexOf(' ') - $_.IndexOf('-') - 1),
        $_.Substring($_.IndexOf(':') - 1, 1),
        $_.Substring($_.IndexOf(': ') + 2)
    )
}

$GoodPasswords = 0
foreach ($Instruction in $Instructions)
{
    $CharCount = [regex]::matches($Instruction.Password, $Instruction.Character).count
    if (($CharCount -ge $Instruction.Min) -and ($CharCount -le $Instruction.Max))
    {
        $GoodPasswords++
    }
}

Write-Host "Day 2 Part 1: $($GoodPasswords)"

$GoodPasswords = 0
foreach ($Instruction in $Instructions)
{
    if (($Instruction.Password.Substring($Instruction.Min - 1, 1) -eq $Instruction.Character) -xor ($Instruction.Password.Substring($Instruction.Max - 1, 1) -eq $Instruction.Character))
    {
        $GoodPasswords++
    }
}

Write-Host "Day 2 Part 2: $($GoodPasswords)"