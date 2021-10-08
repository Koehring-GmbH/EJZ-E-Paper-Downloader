@echo off
REM ****************************************************************************************
REM                                 EJZ E-Paper Downloader
REM ****************************************************************************************
REM Version 1.0
REM Author: Alexander Rüter
REM www.koehring.net / support@ejz.de
REM Copyright (c), Druck- und Verlagsgesellschaft Köhring GmbH & Co. KG, All rights reserved
REM ****************************************************************************************



REM Benutzername und Passwort mit den EJZ-Logindaten austauschen.
set user=Benutzername
set pass=Passwort
REM Den Speicherort hier angeben! Beispiel: \\nas\EJZ oder C:\Users
set pdf-location=\\nas\EJZ



REM HIER NICHTS ANFASSEN!!!

for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"

set "today=%YYYY%-%MM%-%DD%"
set folder=\%YYYY%\%MM%\
if not exist "%pdf-location%%folder%" mkdir "%pdf-location%%folder%"

set filename=EJZ_%today%.pdf
set output=--output %pdf-location%%folder%%filename%

set login-param=--form "name=%user%" --form "pass=%pass%"
set download-param= "https://www.ejz.de/epaper/get.php?&datum=%today%&ausgabe=&datei=EJZ_%today%&action=download"

curl --cookie-jar C:\tmp\ejz-cookie.txt %login-param% "https://www.ejz.de/index.php?action=login"
curl -b C:\tmp\ejz-cookie.txt %output% %download-param%
