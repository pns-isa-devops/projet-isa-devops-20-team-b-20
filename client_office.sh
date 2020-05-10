#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

echo ""
echo "Attaching to dd-client-office docker container"
echo "To detach the tty without exiting the shell"
echo "use the escape sequence Ctrl-p + Ctrl-q"
echo "note: This will continue to exist in a stopped state once exited (see \"docker ps -a\")"
echo ""
echo "type help to display the commands"
echo ">"
docker attach dd-client-office
