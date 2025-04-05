Per creare il primo utente amministratore è necessario collegarsi
alla shell del container di Passbolt e lanciare il seguente comando:

```
/usr/share/php/passbolt/bin/cake \
passbolt register_user \
-u mail@example.tld \
-f Firstname \
-l Lastname \
-r admin
```

Dopodiché accedere all'URL ricevuto via mail o restituito dallo
script per procedere con l'onboarding dell'account.
