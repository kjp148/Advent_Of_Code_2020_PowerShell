$PuzzleInput = Get-Content .\Input\day1.txt

$PuzzleInput | ForEach-Object {
    $First = $_
    $PuzzleInput | ForEach-Object {
        $Second = $_
        if ($First + $Second -eq 2020)
        {
            
        }
    }
}