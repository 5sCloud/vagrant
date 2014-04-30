# Come aggiornare Saltstack

Nel caso si debba aggiornare saltstack all'ultima versione disponibile

## Opzione 1
Accedete in SSH alla macchina vagrant mentre è in esecuzione
```sh
$ vagrant ssh
```
Una volta effettuato l'accesso potete aggiornare i pacchetti salt-common e salt-minion da shell eseguendo i seguenti comandi:
```sh
<vm> $ sudo apt-get update
<vm> $ sudo apt-get upgrade salt-common salt-minion
```

## Opzione 2
Effettuate l'accesso SSH alla macchina vagrant
```sh
$ vagrant ssh
```
Cancellate i pacchietti salt-common e salt-minion; questi verranno reinstallati automaticamente quando chiamerete il comando `vagrant provision`
```sh
<vm> $ sudo apt-get purge salt-common salt-minion
```

## Opzione 3 (sconsigliata)
Ricreate da zero la macchina vagrant
```sh
$ vagrant destroy
$ vagrant up
```

Questo aggiornerà ovviamente saltstack all'ultima versione, ma vi farà anche perdere tutte le modifiche che avete fatto all'interno della macchina vagrant (es: tutte le modifiche a database)

