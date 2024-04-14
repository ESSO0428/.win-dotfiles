oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\blue-owl.omp.json" | Invoke-Expression
#  Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView


# git clone --depth 1 https://github.com/junegunn/fzf.git .fzf
# cd .fzf
# .\install.psl

# 於系統管理員模式
# Install-Module PSFzf -RequiredVersion 2.4.0
# 或非管理員模式
# Install-Module -Name PSFzf -Scope CurrentUser -Force -RequiredVersion 2.4.0
# 打開這個 cofig 檔
# notepad $PROFILE
# 將設定值設定成如本檔所示 (powershell 全部關閉之後再重開即可)
# enjoy

# 上述若失敗請再執行下面的 code (代表 fzf.git 沒有被綁到環境)
# choco install fzf
# 若沒有 choco 可以用 scoop 安裝 (scoop 也要另外裝，不過安裝指另比較簡單)
# scoop install fzf

Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
$env:FZF_DEFAULT_OPTS="--height 40% --layout=reverse"


Set-Alias lvim 'C:\Users\Andy6\.local\bin\lvim.ps1'

