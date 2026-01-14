# 🚀 NCS - Multi-Version PHP Dev Environment

Repozytorium zawiera gotowe, zoptymalizowane środowisko deweloperskie oparte na Dockerze, umożliwiające jednoczesną pracę na dwóch wersjach PHP.

## 📂 Struktura Projektu

| Folder / Plik | Opis |
| :--- | :--- |
| `/www` | **Miejsce na Twój kod źródłowy PHP** (wspólny dla obu wersji). |
| `/mysql_data` | Przechowuje pliki bazy danych (nie edytuj ręcznie). |
| `php73.Dockerfile` | Konfiguracja PHP 7.3 + Nginx + ionCube + Xdebug. |
| `php83.Dockerfile` | Konfiguracja PHP 8.3 + Nginx + ionCube + Xdebug. |
| `docker-compose.yml` | Definicja usług i połączeń między nimi. |
| `manage.bat` / `.sh` | Skrypty do szybkiego zarządzania środowiskiem. |

---

## 🌐 Dostępne Usługi

Po uruchomieniu środowisko dostępne jest pod następującymi adresami:

* **PHP 7.3 + Nginx:** [http://localhost:8073](http://localhost:8073)
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

### Xdebug
Xdebug jest skonfigurowany na porcie `9003`. 
- **Client Host:** `host.docker.internal`
- **Mode:** `develop,debug`

### Nginx Root
Domyślny `WEBROOT` ustawiony jest na `/var/www/html/`. Jeśli Twój projekt startuje z podfolderu (np. `/public`), zmień zmienną `WEBROOT` w pliku `docker-compose.yml`.

---
*Ostatnia aktualizacja dokumentacji: 14.01.2026*
