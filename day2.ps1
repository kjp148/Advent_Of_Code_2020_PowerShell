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
        $_.substring(0, $_.IndexOf('-')),
        $_.substring($_.IndexOf('-') + 1, $_.IndexOf(' ') - $_.IndexOf('-') - 1),
        $_.substring($_.IndexOf(':') - 1, 1),
        $_.substring($_.IndexOf(': ') + 2)
    )
}
