# version: 20210211
# Writer: TerAnYu

:log info "Starting Automatic Backup Script"
:local FTPserverAddress "ftp.server.com";
:local serverport 21;
:local FTPuser "ftpuser";
:local FTPpass "ftppassword";
:local hostname [/system identity get name];
:local certpassphrase "123456789";
:local certtype "pkcs12";
:local hwsn [system routerboard get serial-number];


:local thisdate [/system clock get date]
:local thistime [/system clock get time]
:local datetimestring ([:pick $thisdate 0 3] ."-" . [:pick $thisdate 4 6] ."-" . [:pick $thisdate 7 11])
:local timetimestring ([:pick $thistime 0 2] ."-" . [:pick $thistime 3 5] ."-" . [:pick $thistime 6 8])
:local backupfilename ($datetimestring."_".$timetimestring."_1w")

/export terse file="$backupfilename"
:delay 5s
/system backup save name="$backupfilename"
:delay 5s

:foreach certname in=[/certificate find] do={
:local name [/certificate get $certname name]
:do { /certificate export-certificate [find name=$"name"] export-passphrase="$passphrase" type="$certtype" } on-error={}
}

:delay 5s

:foreach FILE in=[/file find type!=directory size>0] do={ 
:local name [/file get $FILE name];
:if ( $"name" ~ "/" ) do={} else={
:do { [/tool fetch mode=ftp address="$FTPserverAddress" port="$serverport" src-path="$name" user="$FTPuser" password="$FTPpass" dst-path="[$hostname]-[$hwsn]_$name" upload=yes] } on-error={:log error message="FTP upload failed: $name"}
}}

:delay 3s
/file remove "$backupfilename.rsc"

:delay 3s
/file remove "$backupfilename.backup"

:log info "Backup Script Finished!"
