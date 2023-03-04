function Set-GhqLocation($toolName) {
    if ($env:GHQ_SELECTOR -eq $null) {
        $toolName = "fzf"
    } else {
        $toolName = $env:GHQ_SELECTOR
    }
    switch($toolName) {
        "fzf" { $ghqRepo = ghq list -p | fzf }
        "peco" { $ghqRepo = ghq list -p | peco }
        "skim" { $ghqRepo = ghq list -p | sk }
        * { Write-Output "ERROR: Set-GhqLocation is not support $toolName"; exit 1 }
    }

    Set-Location $ghqRepo
}
