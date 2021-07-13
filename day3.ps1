$horiz = 0
$TreeCount = 0

foreach ($Line in (Get-Content .\Input\day3.txt))
{
    if ($Line[$horiz] -eq '#')
    {
        $TreeCount++
    }

    $horiz += 3 # Down one over three (Down is covered by foreach)
    $horiz %= $Line.Length # Wrap
}

Write-Host "Day 3 Part 1: $($TreeCount)"