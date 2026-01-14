# **🚀 NCS \- Multi-Version PHP Dev Environment**

Gotowe środowisko Dockerowe do pracy nad aplikacjami PHP na wersjach 7.3 oraz 8.3 z bazą MySQL 8.0 i Redis 7\.

## **📂 Struktura Projektu**

| Folder / Plik | Opis |
| :---- | :---- |
| /www | **Miejsce na kod PHP.** Folder mapowany do /var/www/html/ w kontenerach. |
| /mysql\_data | Dane bazy danych (trwałe po restarcie). |
| manage.bat / .sh | Skrypty sterowania: Update, Start, Restart, Stop. |
| logs\_live.bat / .sh | Skrypty do podglądu logów w czasie rzeczywistym. |

## **🌐 Dostępne Usługi**

| Usługa | Adres URL / Host | Port |
| :---- | :---- | :---- |
| **PHP 7.3** | [http://localhost:8073](https://www.google.com/search?q=http://localhost:8073) | 8073 |
| **PHP 8.3** | [http://localhost:8083](https://www.google.com/search?q=http://localhost:8083) | 8083 |
| **phpMyAdmin** | [http://localhost:8081](https://www.google.com/search?q=http://localhost:8081) | 8081 |
| **MySQL** | mysql (wewnątrz) / localhost (zewnątrz) | 3306 |
| **Redis** | redis (wewnątrz) / localhost (zewnątrz) | 6379 |

**Baza Danych (MySQL):**

* **User:** root  
* **Pass:** root  
* **DB:** dev\_db

**Cache (Redis):**

* **Host:** redis  
* **Port:** 6379

## **⚙️ Konfiguracja PHP & Docker**

* **NGINX\_WEBROOT:** /var/www/html/ (Twoje pliki index.php powinny być w /www).  
* **PHP\_MEMORY\_LIMIT:** 256M (limit dla silnika PHP).  
* **Docker RAM Limit:** 512MB (limit sprzętowy na kontener PHP).

## **🐞 Konfiguracja VS Code (Xdebug 3\)**

1. Zainstaluj rozszerzenie **PHP Debug**.  
2. Stwórz plik .vscode/launch.json w głównym katalogu projektu:

{  
  "version": "0.2.0",  
  "configurations": \[  
    {  
      "name": "Listen for Xdebug",  
      "type": "php",  
      "request": "launch",  
      "port": 9003,  
      "pathMappings": {  
        "/var/www/html": "${workspaceRoot}/www"  
      }  
    }  
  \]  
}

3. Uruchom nasłuchiwanie klawiszem **F5**.

## **🐘 Konfiguracja PHPStorm (XStorm)**

1. Dodaj serwer w Settings \> PHP \> Servers:  
   * **Host:** localhost, **Port:** 8073 (lub 8083).  
   * Zaznacz **Use path mappings**.  
   * Mapuj lokalny folder /www na zdalny /var/www/html.  
2. Sprawdź Settings \> PHP \> Debug, czy port to 9003\.  
3. Włącz ikonę "słuchawki" w prawym górnym rogu.

## **🚀 Szybkie Starty**

1. **Aktualizacja i budowa:** manage \-\> update  
2. **Uruchomienie:** manage \-\> start  
3. **Logi na żywo:** Uruchom logs\_live.bat (pozostanie otwarte).
