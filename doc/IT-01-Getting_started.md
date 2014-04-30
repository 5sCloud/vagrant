# Come iniziare ad usare vagrant come ambiente di sviluppo

## Prerequisiti:
### 1. VirtualBox
Scarica VirtualBox (<https://www.virtualbox.org/wiki/Downloads>) ed installalo

### 2. Vagrant
Scarica ed installa Vagrant (<http://www.vagrantup.com/downloads.html>)
IMPORTANTE: Non scaricare una versione da downloads.vagrantup.com! Sono versioni vecchie e non sono più mantenute. Accertati di scaricare l'ultima versione di Vagrant (in questo momento la 1.5.4)

### 3. Installa il plugin vagrant-shell-commander
In shell:
```sh
$ vagrant plugin install vagrant-shell-commander
```

### 4. Link al progetto
Una volta clonato il progetto principale, crea un symlink alla cartella di progetto chiamato `project`. Questo servirà come cartella condivisa per la macchina virtuale.
```sh
$ ln -s /home/foo/projects/m5s ./project
```
**UTENTI WINDOWS**: Dato il mancato supporto di VirtualBox per le junction gli utenti windows DEVONO clonare il progetto principale direttamente dentro la cartella project, quindi senza creare un collegamento. 

### 5. Up
```sh
$ vagrant up
```
Una volta finito di fare il provisioning la virtual machine è attiva ed il webserver è in funzione.
Prova a verificare che tutto sia andato a buon fine accedendo dal browser all'indirizzo http://192.168.33.22/phpmyadmin

### 6. /etc/hosts
Dato che le configurazioni di progetto sono host-based, per accedere correttamento al sito di sviluppo devi modificare il file `/etc/hosts` (su windows `C:\Windows\system32\drivers\etc\hosts`) aggiungendo questa linea:
```
192.168.33.22    m5s.local api.m5s.local static.m5s.local
```

### 7. Fine
Se hai fatto tutto correttamente dovresti poter accedere al progetto dall'indirizzo http://m5s.local/app_dev.php/

