As bizarre as this seems, Windows Terminal consistently saves the `settings.json` file to a directory in the following location (yes, with the `8wekyb3d8bbwe` as part of the path! See [here](https://stackoverflow.com/q/63101571/1814970)):

C:\Users\username\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json

So make a symbolic link to that location like this:

```
PS > New-Item `
	-Path C:\Users\username\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json `
	-ItemType SymbolicLink `
	-Value 'C:\Users\username\path-to-your-settings.json'

```

Note: remember to change `username` with your user name and `path-to-your-settings.json`... you got the idea.