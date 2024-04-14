---
title: Win-Dotfiles
author: Andy6
date: Saturday, March, 02, 2024
---

# My Win-Dotfiles

## Install My Windows environment

Will write when I have time

## VimKeyMap For Any Available Editor

This Directory contains the **VimKeyMap** for below available editor
and path to the configuration file for below editors.

```powershell
# In user directory run below command, can get all vimkeymap config
.\.win-dotfiles\LoadMyVimKeyMapForAllEditorOnly.ps1
```

### Visual Studio Code

Copy paste [keymap.vim](./keymap.vim) to below **C:\Users\Andy6**

### Jetbrains IDE

Copy paste [.ideavimrc](./.ideavimrc) to below **C:\Users\Andy6**

### Obsidian

Copy paste [.obsidian.vimrc](./.obsidian.vimrc) to below **C:\Users\Andy6\Documents\Obsidian Vault**

### Neovim Qt

This is the neovim editor with GUI (For Windows).

Copy paste files of [./nvim/](./nvim/) to **C:\Users\Andy6\AppData\Local\nvim**

### Other

`im-select.exe` is a tool to switch between input methods on Windows.

- `im-select.exe` also support vscode, obsidian, neovim/lunavim (remote or wsl)
    + For remote neovim/lunavim, need to `reverse ssh tunnel` to local machine
        * And vimscripts setting (for my vimscript have support; not in this
        directory; just offer user guide in here)
    + Install directories are below
        * **C:\Windows**
        * **C:\Users\Andy6**
    + Download link : [here](https://github.com/daipeihust/im-select/raw/master/win/out/x86/im-select.exe)
        * Have `im-select.exe` in this directory, but if you want to get the latest version, you can download from the link above.
    + Run below command will auto process
        ```powershell
        .\.win-dotfiles\CopyImSelectToSystemPath.ps1
        ```

