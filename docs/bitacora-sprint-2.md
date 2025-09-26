# Bitácora Sprint 2

## Comandos ejecutados
### Verificar socket
```
$ nc -zv google.com 443
Connection to google.com 443 port [tcp/https] succeeded!
```

### Handshake TLS
```
$ openssl s_client -connect google.com:443
...
Protocol  : TLSv1.3
```

## Decisiones
- Se usó `nc` para verificar apertura de socket.
- Se usó `openssl s_client` para handshake y versión mínima TLS.
