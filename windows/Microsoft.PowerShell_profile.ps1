# Provides an interactive menu, somewhat like what zsh does on tab.
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

<#
 # Configures the prompt, to include some newlines between commands, an emoji
 # some details about what kind of terminal this is (debug? admin?) and the full
 # path to the current folder.
 #>
function prompt {
  $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
  $principal = [Security.Principal.WindowsPrincipal] $identity
  $adminRole = [Security.Principal.WindowsBuiltInRole]::Administrator

  "`n`n`n😎 " +

  $(if (Test-Path variable:/PSDebugContext) { '[DBG] ' }
    elseif($principal.IsInRole($adminRole)) { '[ADMIN] ' }
    else { '' }
  ) + 'PS [' + $(Get-Location) + '] em [' + $(Get-Date -Format "dMMMyy HH:mm") + "]`n" +
  $(if ($NestedPromptLevel -ge 1) { '>>' }) + '> '
}
