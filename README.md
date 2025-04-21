# Installation d'un serveur mail basique sur Debian 12

Ce dépôt contient un script bash (`start.sh`) qui permet d’installer un **serveur mail simple** sur un VPS tournant sous **Debian 12**. Il installe et configure automatiquement **Postfix** (SMTP) et **Dovecot** (IMAP/POP3) pour envoyer et recevoir des mails en local.

---

## Ce que fait le script

Le script effectue les étapes suivantes :

- Mise à jour du système
- Installation de :
  - `postfix` : serveur SMTP pour l’envoi de mails
  - `dovecot-core`, `dovecot-imapd`, `dovecot-pop3d` : serveur pour recevoir les mails via IMAP/POP3
  - `mailutils` : pour envoyer des mails via la ligne de commande
- Configuration de Postfix :
  - Définition du nom d’hôte (`myhostname`)
  - Activation de Maildir comme format de boîte mail
- Création d’un utilisateur système `mailuser` avec un mot de passe prédéfini
- Configuration de Dovecot pour utiliser Maildir
- Redémarrage et activation automatique des services `postfix` et `dovecot`

--
