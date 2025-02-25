Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "telnet 192.168.1.1", 1, False
WScript.Sleep 2000
WshShell.SendKeys "Admin"
WshShell.SendKeys "{ENTER}"
WScript.Sleep 1000
WshShell.SendKeys "PASSWORD"
WshShell.SendKeys "{ENTER}"
WScript.Sleep 1000
WshShell.SendKeys "reboot"
WshShell.SendKeys "{ENTER}"
WScript.Sleep 3000
WshShell.SendKeys "exit"
WshShell.SendKeys "{ENTER}"
WScript.Sleep 1000
WshShell.SendKeys "%{F4}" ' Press ALT+F4 to close the window
