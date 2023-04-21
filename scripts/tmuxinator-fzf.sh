function start_project() {
    tmx start $(echo "$input" | awk 'NR>1 { gsub(/ +/, "\n"); print }' | fzf)
}

alias projects=start_project
