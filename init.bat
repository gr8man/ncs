@echo off
setlocal

echo [INFO] Sprawdzanie struktury katalogow...

:: Sprawdzamy czy konfiguracja już istnieje, aby jej nie nadpisać przypadkiem
if exist "docker\nginx\74" (
    echo [INFO] Konfiguracja lokalna znaleziona. Pomijam ekstrakcje plikow.
    goto START_CONTAINERS
)

echo [INFO] Konfiguracja nie istnieje. Rozpoczynam procedure ekstrakcji...

:: 1. Budowanie obrazów (tylko by wyciągnąć pliki)
echo [INFO] Budowanie obrazow pomocniczych...
docker build -f php74.Dockerfile -t temp_extract_74 .
docker build -f php83.Dockerfile -t temp_extract_83 .

:: 2. Tworzenie katalogów lokalnych
echo [INFO] Tworzenie struktury katalogow...
if not exist "docker\nginx\74" mkdir "docker\nginx\74"
if not exist "docker\php\74" mkdir "docker\php\74"
if not exist "docker\nginx\83" mkdir "docker\nginx\83"
if not exist "docker\php\83" mkdir "docker\php\83"

:: 3. Ekstrakcja plików (tworzymy kontener -> kopiujemy -> usuwamy kontener)
echo [INFO] Kopiowanie plikow z PHP 7.4...
docker create --name tmp_copy_74 temp_extract_74
docker cp tmp_copy_74:/etc/nginx/. ./docker/nginx/74/
docker cp tmp_copy_74:/usr/local/etc/php/. ./docker/php/74/
docker rm tmp_copy_74

echo [INFO] Kopiowanie plikow z PHP 8.3...
docker create --name tmp_copy_83 temp_extract_83
docker cp tmp_copy_83:/etc/nginx/. ./docker/nginx/83/
docker cp tmp_copy_83:/usr/local/etc/php/. ./docker/php/83/
docker rm tmp_copy_83

echo [SUCCESS] Pliki konfiguracyjne zostaly skopiowane na hosta.

:START_CONTAINERS
echo [INFO] Uruchamianie srodowiska Docker...
docker compose up -d --build

echo [SUCCESS] Gotowe! Twoje srodowisko dziala.
pause
