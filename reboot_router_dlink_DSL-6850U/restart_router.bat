@echo off
echo %DATE% %TIME% - Restarting router... >> C:\scripts\DSL-6850U\router_restart.log

:: Run the VBScript to restart the router
cscript C:\scripts\DSL-6850U\restart_router.vbs >> C:\scripts\DSL-6850U\router_restart.log 2>&1

echo %DATE% %TIME% - Restart command sent. >> C:\scripts\DSL-6850U\router_restart.log

:: Count the number of lines in the log file
for /f %%A in ('find /c /v "" ^< C:\scripts\DSL-6850U\router_restart.log') do set COUNT=%%A

:: If the log file has more than 30 lines, delete it
if %COUNT% GTR 30 del C:\scripts\DSL-6850U\router_restart.log
