function Set-GhqLocation() {
    if ($null -eq $env:GHQ_SELECTOR) {
        $toolName = "fzf"
    } else {
        $toolName = $env:GHQ_SELECTOR
    }
    switch($toolName) {
        "fzf" {
            Set-Location (ghq list -p | fzf)
        }
        "peco" {
            Set-Location (ghq list -p | peco)
        }
        * {
            Write-Output "ERROR: Set-GhqLocation is not support $toolName"
            exit 1
        }
    }
}
