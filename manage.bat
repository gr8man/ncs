@echo off
SET /P choice="Wybierz opcje (update, start, restart, stop): "

IF /I "%choice%"=="update" GOTO update
IF /I "%choice%"=="start" GOTO start
IF /I "%choice%"=="restart" GOTO restart
IF /I "%choice%"=="stop" GOTO stop

:update
git pull origin main
docker compose build
GOTO end

:start
docker compose up -d
GOTO end

:restart
docker compose restart
GOTO end

:stop
docker compose stop
GOTO end

:end
pause
