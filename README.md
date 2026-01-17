### **Dokumentacja Techniczna Środowiska Deweloperskiego**

**1. Przegląd**

To środowisko deweloperskie oparte na technologii Docker, przeznaczone do uruchamiania aplikacji PHP. Umożliwia ono pracę w skonteneryzowanym środowisku, zapewniając spójność i izolację od systemu operacyjnego hosta. Środowisko jest skonfigurowane tak, aby jednocześnie udostępniać aplikacje PHP w wersjach 7.4 i 8.3 na różnych portach.

**2. Wymagania**

Przed rozpoczęciem pracy upewnij się, że na Twoim komputerze zainstalowane są następujące narzędzia:
*   **Docker**
*   **Docker Compose** (zazwyczaj dołączony do instalacji Docker Desktop)

**3. Konfiguracja**

Główna konfiguracja środowiska znajduje się w pliku `.env`. Plik ten służy do przechowywania zmiennych środowiskowych, które są wykorzystywane przez `docker-compose.yml` do budowania i uruchamiania kontenerów.

**Przed pierwszym uruchomieniem należy skonfigurować następujące zmienne:**

**a) Ścieżka do repozytorium projektu**

Kluczowe jest wskazanie w pliku `.env` absolutnej ścieżki do folderu z kodem Twojej aplikacji (tego repozytorium). Ta ścieżka jest potrzebna, aby zamontować pliki projektu do kontenera serwera WWW.

Dodaj do pliku `.env` wpis `PROJECT_PATH`, na przykład:

*   **Linux / macOS:**
    ```
    PROJECT_PATH=/home/dom/nci/test123/ncs
    ```

*   **Windows:**
    ```
    PROJECT_PATH=C:/Users/user/dev/ncs
    ```
*(Pamiętaj, aby podać aktualną, pełną ścieżkę do tego projektu na Twoim dysku)*


**4. Użycie**

Projekt zawiera skrypty `.bat` przeznaczone dla systemu Windows. Ponieważ pracujesz w środowisku Linux, poniżej znajdują się odpowiadające im komendy `docker-compose`.

*   **Inicjalizacja / Przygotowanie struktury (`system-init.bat`)**
    Służy do przygotowania początkowej struktury środowiska oraz zbudowania obrazów Docker na podstawie plików `php74.Dockerfile` i `php83.Dockerfile`. Należy wykonać tę komendę przy pierwszej konfiguracji.

    ```bash
    docker-compose build
    ```
    Jeśli chcesz wymusić przebudowanie obrazów bez użycia cache, użyj:
    ```bash
    docker-compose build --no-cache
    ```

*   **Uruchamianie środowiska (`system-start.bat`)**
    Uruchamia wszystkie kontenery w tle (tryb detached). Po uruchomieniu, aplikacje PHP będą dostępne na następujących portach na `localhost`:
    *   **PHP 7.4:** `http://localhost:8074`
    *   **PHP 8.3:** `http://localhost:8083`

    ```bash
    docker-compose up -d
    ```

*   **Zatzymywanie środowiska (`system-stop.bat`)**
    Zatrzymuje i usuwa uruchomione kontenery, sieci oraz wolumeny zdefiniowane w `docker-compose.yml`.

    ```bash
    docker-compose down
    ```

*   **Podgląd logów (`system-log.bat`)**
    Wyświetla logi generowane przez kontenery w czasie rzeczywistym.

    ```bash
    docker-compose logs -f
    ```

**5. Dodatkowe usługi i Baza Danych**

Środowisko deweloperskie zawiera dodatkowe usługi, takie jak Redis, phpMyAdmin oraz bazę danych MariaDB.

*   **phpMyAdmin**
    Interfejs do zarządzania bazą danych jest dostępny pod adresem: `http://localhost:8081`

*   **Redis**
    Serwer Redis jest dostępny dla aplikacji na standardowym porcie: `6379`.

*   **Połączenie z bazą danych (MariaDB)**
    Poniżej znajdują się dane potrzebne do połączenia z bazą danych.

    **a) Połączenie z aplikacji PHP (wewnątrz kontenera Docker)**
    Aplikacje PHP uruchomione w kontenerach powinny używać nazwy usługi jako hosta.
    *   **Host:** `mysql`
    *   **Baza danych:** `dev_db`
    *   **Użytkownik:** `root`
    *   **Hasło:** `root`
    *   **Port:** `3306`

    **b) Połączenie z zewnątrz (np. z HeidiSQL, DBeaver, DataGrip)**
    Aby połączyć się z bazą danych z programu na Twoim komputerze, użyj poniższych danych.
    *   **Host:** `127.0.0.1`,`localhost` lub adres ip komputera (połączenie z sieci lokalnej)
    *   **Baza danych:** `dev_db`
    *   **Użytkownik:** `root`
    *   **Hasło:** `root`
    *   **Port:** `3306`


**6. Struktura plików (główne komponenty)**

*   `docker-compose.yml`: Główny plik orkiestracji Docker Compose, który definiuje usługi (np. serwery WWW dla PHP 7.4 i 8.3), sieci i wolumeny.
*   `php74.Dockerfile`: Definicja obrazu Docker dla środowiska z PHP 7.4.
*   `php83.Dockerfile`: Definicja obrazu Docker dla środowiska z PHP 8.3.
*   `.env`: Plik konfiguracyjny do przechowywania zmiennych (np. ścieżka projektu).

