# dotfiles

Personal Neovim config. lazy.nvim + Rust dev environment.

## Stack

- **Plugin manager**: lazy.nvim
- **LSP / Rust**: rustaceanvim + rust-analyzer
- **Completion**: nvim-cmp + LuaSnip
- **Fuzzy finder**: Telescope
- **File tree**: neo-tree
- **Formatter**: conform.nvim (rustfmt, stylua)
- **Diagnostics**: tiny-inline-diagnostic + Trouble
- **Theme**: One Dark

## Requirements

| Tool | Install |
|------|---------|
| Neovim >= 0.10 | [neovim.io](https://neovim.io) |
| Git | |
| Rust / rustup | [rustup.rs](https://rustup.rs) — includes `rustfmt`, `rust-analyzer` |
| Node.js | optional, some LSPs need it |

## Install

### Windows (PowerShell as Administrator)

```powershell
git clone https://github.com/cet-t/dotfiles $HOME\dotfiles
cd $HOME\dotfiles
.\install.ps1
nvim
```

### Linux / Mac

```bash
git clone https://github.com/cet-t/dotfiles ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
nvim
```

First launch installs all plugins automatically via lazy.nvim.

## Key Bindings

`<leader>` = `Space`

### Navigation

| Key | Action |
|-----|--------|
| `<C-n>` | Toggle file tree |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<S-h>` / `<S-l>` | Prev / Next buffer |
| `<leader>bd` | Close buffer |

### LSP / Rust

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | References |
| `K` | Hover docs |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename |
| `<leader>cf` | Format file |
| `<leader>rr` | Rust runnables |
| `<leader>rt` | Rust testables |
| `<leader>re` | Expand macro |

### Diagnostics

| Key | Action |
|-----|--------|
| `[d` / `]d` | Prev / Next diagnostic |
| `<leader>e` | Diagnostic float |
| `<leader>xx` | Trouble: all diagnostics |
| `<leader>xX` | Trouble: buffer diagnostics |

### Terminal

| Key | Action |
|-----|--------|
| `<C-\>` | Toggle floating terminal |
| `<leader>th` | Toggle bottom terminal |

### Claude Code

| Key | Action |
|-----|--------|
| `<leader>ac` | Open Claude Code |
| `<leader>ar` | Resume last session |
