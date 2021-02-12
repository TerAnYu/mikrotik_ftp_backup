# mikrotik_ftp_backup
Mikrotik FTP Backup

Позволяет делать бэкап, экспорт настроек и сохранять все доступные установленные
сертификаты в системе, содержимое корня диска и отправляет все это дело на FTP.

Формат файлов на FTP будет выглядеть так:
```
[identity]-[serialnumber]_other_file_as_root.backup
[identity]-[serialnumber]_cert_export_CA.crt
[identity]-[serialnumber]_cert_export_CA.p12
[identity]-[serialnumber]_cert_export_server.p12
[identity]-[serialnumber]_feb-12-2021_11-35-37_1w.backup
[identity]-[serialnumber]_feb-12-2021_11-35-37_1w.rsc
```
