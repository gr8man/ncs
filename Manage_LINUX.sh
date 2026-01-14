#!/bin/bash
echo "Wybierz opcje: 1) update, 2) start, 3) restart, 4) stop"
read choice

case $choice in
    1|update)
        git pull origin main
        docker compose build
        ;;
    2|start)
        docker compose up -d
        ;;
    3|restart)
        docker compose restart
        ;;
    4|stop)
        docker compose stop
        ;;
    *)
        echo "Nieprawidlowy wybor"
        ;;
esac
