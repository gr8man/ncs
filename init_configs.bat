@echo off
setlocal enabledelayedexpansion

:: Tablica wersji
set VERSIONS=74 83

for %%V in (%VERSIONS%) do (
    echo --- Przetwarzanie PHP %%V ---

    :: Tworzenie folderów
    if not exist "nginx\%%V" mkdir "nginx\%%V"
    if not exist "php\%%V" mkdir "php\%%V"

    :: Budowanie obrazu
    docker build -t php%%V_temp_img -f php%%V.Dockerfile .

    :: Tworzenie tymczasowego kontenera i przechwycenie jego ID
    for /f "tokens=*" %%I in ('docker create php%%V_temp_img') do set CONTAINER_ID=%%I

    :: Kopiowanie plików
    echo Kopiowanie plikow dla wersji %%V...
    docker cp !CONTAINER_ID!:/etc/nginx/. ./nginx/%%V/
    docker cp !CONTAINER_ID!:/usr/local/etc/php/. ./php/%%V/

    :: Usuniecie kontenera
    docker rm !CONTAINER_ID!
)

echo.
echo Gotowe! Pliki znajduja sie w folderach \nginx i \php.
pause
