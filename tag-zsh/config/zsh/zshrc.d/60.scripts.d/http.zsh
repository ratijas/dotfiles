function http-share-dir() {
    if [[ "$1" =~ '--help|-h' ]]; then
        echo "$0 - Share a directory over local letwork via HTTP server."
        echo "  Listens on interface 0.0.0.0!"
        echo
        echo 'Usage: http-share-dir [ <directory> [ <port> ] ]'
        echo
        echo '    <directory> - which directory to share, default: current directory'
        echo '    <port>      - on which port server starts, default: 8080'
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
