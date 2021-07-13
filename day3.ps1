[string[]]$Map = (Get-Content .\Input\day3.txt)
$TreesMultiplied = 1

# Part 2 modifiers (index 1 is part 1)
[int[]]$VertModifier = (1, 1, 1, 1, 2)
[int[]]$HorizModifier = (1, 3, 5, 7, 1)

for ([int]$ModifierI = 0; $ModifierI -lt $VertModifier.Length; $ModifierI++)
{
    $Vert = 0
    $Horiz = 0
    $TreeCount = 0
    for ([int]$Vert = 0; $Vert -lt $Map.Length; $Vert += $VertModifier[$ModifierI])
    {
        if ($Map[$Vert][$Horiz] -eq '#')
        {
            $TreeCount++
        }
        $Horiz += $HorizModifier[$ModifierI]
        $Horiz %= $Line.Length # Wrap
    }

    if ($ModifierI -eq 1) # part 1
    {
        Write-Host "Day 3 Part 1: $($TreeCount)"
    }
    $TreesMultiplied *= $TreeCount
}

Write-Host "Day 3 Part 2: $($TreesMultiplied)"