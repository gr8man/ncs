#!/bin/bash

# Tablica wersji
VERSIONS=("74" "83")

for VER in "${VERSIONS[@]}"; do
    echo "--- Przetwarzanie PHP $VER ---"
    
    # Tworzenie folderów
    mkdir -p "./nginx/$VER" "./php/$VER"

    # Budowanie obrazu (wykorzystuje Twoje Dockerfile)
    docker build -t "php${VER}_temp_img" -f "php${VER}.Dockerfile" .

    # Tworzenie tymczasowego kontenera (bez uruchamiania go)
    CONTAINER_ID=$(docker create "php${VER}_temp_img")

    # Kopiowanie plików
    echo "Kopiowanie plików dla wersji $VER..."
    docker cp "$CONTAINER_ID:/etc/nginx/." "./nginx/$VER/"
    docker cp "$CONTAINER_ID:/usr/local/etc/php/." "./php/$VER/"

    # Usunięcie tymczasowego kontenera
    docker rm "$CONTAINER_ID"
    
    # Naprawa uprawnień dla Linuxa
    chmod -R 755 "./nginx/$VER" "./php/$VER"
done

echo "Gotowe! Pliki znajdują się w folderach ./nginx i ./php"
