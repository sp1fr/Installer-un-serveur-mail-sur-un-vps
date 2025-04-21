#!/bin/bash

# Script de base pour installer un serveur mail avec Postfix + Dovecot sur Debian 12

# Mettre à jour les paquets
apt update && apt upgrade -y

# Installer Postfix et Dovecot
DEBIAN_FRONTEND=noninteractive apt install -y postfix dovecot-core dovecot-imapd dovecot-pop3d mailutils

# Configuration rapide de Postfix
echo "Configuration de Postfix..."
postconf -e "myhostname = mail.example.com"
postconf -e "myorigin = /etc/mailname"
postconf -e "mydestination = \$myhostname, localhost.\$mydomain, localhost"
postconf -e "inet_interfaces = all"
postconf -e "inet_protocols = all"
postconf -e "home_mailbox = Maildir/"

# Configurer les alias
echo "root: admin@example.com" >> /etc/aliases
newaliases

# Créer un utilisateur de test
useradd -m -s /bin/bash mailuser
echo "mailuser:password" | chpasswd
mkdir -p /home/mailuser/Maildir
chown -R mailuser:mailuser /home/mailuser/Maildir

# Configuration de Dovecot pour Maildir
echo "mail_location = maildir:~/Maildir" >> /etc/dovecot/conf.d/10-mail.conf

# Autoriser les connexions IMAP et POP3
sed -i 's/^#protocols = .*/protocols = imap pop3 lmtp/' /etc/dovecot/dovecot.conf

# Redémarrer les services
systemctl restart postfix
systemctl restart dovecot

# Activer au démarrage
systemctl enable postfix
systemctl enable dovecot

echo "Installation terminée !"
echo "Vous pouvez tester avec un client mail en IMAP (port 143) ou envoyer un mail avec 'mail mailuser'"

# Connecte-toi en tant que mailuser 
su - mailuser
