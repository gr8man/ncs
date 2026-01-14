@echo off
title LIVE LOGS - PHP 7.4 i 8.3
echo Czekam na nowe logi (uzyj Ctrl+C aby zatrzymac)...
echo ---------------------------------------------------
:: -f oznacza 'follow' (sledz na zywo)
:: --tail=10 pokazuje tylko kilka ostatnich linii na start
docker compose logs -f --tail=10 php74 php83
echo ---------------------------------------------------
echo Polaczenie przerwane.
pause
