$PuzzleInput = @()
Get-Content .\Input\day1.txt | ForEach-Object {
    $PuzzleInput += [int]$_
}

$Done = $false
foreach ($First in $PuzzleInput) {
    foreach ($Second in $PuzzleInput) {
        if (($First + $Second) -eq 2020)
        {
            Write-Host "Day 1 Part 1: $($First) + $($Second) = $($First * $Second)"
            $Done = $true
            break
        }
    }

    if ($Done)
    {
        break
    }
}

$Done = $false
foreach ($First in $PuzzleInput) {
    foreach ($Second in $PuzzleInput) {
        foreach ($Third in $PuzzleInput) {
            if (($First + $Second + $Third) -eq 2020)
            {
                Write-Host "Day 1 Part 2: $($First) + $($Second) + $($Third) = $($First * $Second * $Third)"
                $Done = $true
                break
            }
        }

        if ($Done)
        {
            break
        }
    }

    if ($Done)
    {
        break
    }
}