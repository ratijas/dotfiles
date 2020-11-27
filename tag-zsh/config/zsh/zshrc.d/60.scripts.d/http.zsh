function http-share-dir() {
    if [[ "$1" =~ '--help|-h' ]]; then
        autoload -U more-colors && more-colors

        echo "$0 - share a directory over local letwork via HTTP server."
        echo "  Listens on all interfaces (0.0.0.0)!"
        echo
        echo "Usage: "
        echo "    $bold_color$0$reset_color [ ${underline_color}<directory>${reset_color} [ ${underline_color}<port>${reset_color} ] ]"
        echo
        echo "    ${underline_color}<directory>${reset_color} - which directory to share, default: current directory"
        echo "    ${underline_color}<port>${reset_color}      - on which port server starts, default: 8080"
        return 1
    fi
    local directory="${1:-$PWD}"
    local port="${2:-8080}"
    python -m http.server \
        "${port}" \
        --bind 0.0.0.0 \
        --directory "${directory}" \
        &                                           # background job
    sleep 1                                         # give server some time to launch
    local url="http://${HOST}.local:${port}/"       # / at the end is important
    echo "Open ${url} in browser"
    xdg-open "${url}"
    fg                                              # bring server to foreground
}
