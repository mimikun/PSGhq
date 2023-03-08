function Set-GhqLocation() {
    Set-Location (ghq list -p | fzf)
}
