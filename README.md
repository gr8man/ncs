# 🚀 NCS - Multi-Version PHP Dev Environment

Repozytorium zawiera gotowe, zoptymalizowane środowisko deweloperskie oparte na Dockerze, umożliwiające jednoczesną pracę na dwóch wersjach PHP.

## 📂 Struktura Projektu

| Folder / Plik | Opis |
| :--- | :--- |
| `/www` | **Miejsce na Twój kod źródłowy PHP** (wspólny dla obu wersji). |
| `/mysql_data` | Przechowuje pliki bazy danych (nie edytuj ręcznie). |
| `php74.Dockerfile` | Konfiguracja PHP 7.4 + Nginx + ionCube + Xdebug. |
| `php83.Dockerfile` | Konfiguracja PHP 8.3 + Nginx + ionCube + Xdebug. |
| `docker-compose.yml` | Definicja usług i połączeń między nimi. |
| `manage.bat` / `.sh` | Skrypty do szybkiego zarządzania środowiskiem. |

---

## 🌐 Dostępne Usługi

Po uruchomieniu środowisko dostępne jest pod następującymi adresami:

* **PHP 7.4 + Nginx:** [http://localhost:8074](http://localhost:8074)
* **PHP 8.3 + Nginx:** [http://localhost:8083](http://localhost:8083)
* **phpMyAdmin:** [http://localhost:8081](http://localhost:8081)
* **MySQL:** `localhost:3306`

---

## 🗄️ Połączenie z Bazą Danych (PHP)

Wewnątrz aplikacji używaj poniższych danych:

- **Host:** `mysql`
- **Użytkownik:** `root`
- **Hasło:** `root`
- **Baza danych:** `dev_db`
- **Port:** `3306`

---

## 🚀 Instrukcja obsługi

### 1. Pierwsze uruchomienie (lub zmiana w Dockerfile)
Uruchom skrypt `manage` (lub terminal) i wybierz opcję **update**:
- Pobierze najnowszy kod z GitHub.
- Zbuduje obrazy i zainstaluje wszystkie rozszerzenia (intl, bcmath, imagick, exif, opcache, xdebug, ioncube).

### 2. Praca codzienna
Używaj skryptu `manage` dla operacji:
- **start**: Uruchamia kontenery w tle.
- **restart**: Odświeża kontenery (przydatne przy zmianach w PHP).
- **stop**: Zatrzymuje kontenery, ale zachowuje dane.

---

## 🛠 Rozwiązywanie problemów

### Błąd bazy danych przy pierwszym starcie
Jeśli kontener `mysql_dev` wyświetla błąd w logach dotyczący zainicjowanego folderu, upewnij się, że katalog `/mysql_data` w Twoim projekcie jest **całkowicie pusty**. MySQL 8.0 wymaga czystego folderu przy pierwszej instalacji.

## 🐞 Debugowanie (Xdebug 3)

Kontenery nasłuchują na porcie **9003**.

### 🐘 PHPStorm
1. Dodaj serwer w `Settings > PHP > Servers`:
   - Host: `localhost`, Port: `8073` (lub 8083).
   - Zaznacz **Use path mappings**.
   - Mapuj lokalny folder `/www` na zdalny `/var/www/html`.
2. Włącz "słuchawkę" (**Start Listening for PHP Debug Connections**).

### 📝 VS Code
Dodaj konfigurację do `.vscode/launch.json`:
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for Xdebug",
            "type": "php",
            "request": "launch",
            "port": 9003,
            "pathMappings": {
                "/var/www/html": "${workspaceRoot}/www"
            }
        }
    ]
}

### Nginx Root
Domyślny `WEBROOT` ustawiony jest na `/var/www/html/`. Jeśli Twój projekt startuje z podfolderu (np. `/public`), zmień zmienną `WEBROOT` w pliku `docker-compose.yml`.
### LOGI
Można podglądać logi z serwerów www (jednocześnie dla 7.4 i 8.4) uruchom LOGI_LIVE.bat lub :
:: -f oznacza 'follow' (sledz na zywo)
:: --tail=10 pokazuje tylko kilka ostatnich linii na start
docker compose logs -f --tail=10 php74 php83


---
*Ostatnia aktualizacja dokumentacji: 14.01.2026*
