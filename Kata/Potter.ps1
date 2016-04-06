function Get-SetSize($Table) {
    ($Table | ? { $_ -gt 0 }).Length
}

function Remove-Set($Table) {
    $Table | ForEach-Object {
        if ($_ -gt 0) { $_ - 1 } else { 0 }
    }
}

function Create-Table($Basket) {
    $Table = @(0, 0, 0, 0, 0)
    $Basket | ForEach-Object { $Table[$_ - 1] += 1 }
    $Table
}

function Get-Price($Table) {
    $SetPrice = switch (Get-SetSize $Table) {
        0 { return 0 }
        1 { 8 }
        2 { 2 * 8 * 0.95 }
        3 { 3 * 8 * 0.9  }
        4 { 4 * 8 * 0.8  }
        5 {
            if ((Get-SetSize (Remove-Set $Table)) -eq 3) {
                $Table = Remove-Set $Table
                2 * 4 * 8 * 0.8
            } else {
                5 * 8 * 0.75
            }
        }
    }
    return $SetPrice + (Get-Price (Remove-Set $Table))
}

function Calculate-Price($basket) {
    return Get-Price (Create-Table $Basket)
}