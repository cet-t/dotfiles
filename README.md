# dotfiles

Neovim 設定。lazy.nvim + Rust / C++ / Zig 開発環境。

## 構成

| カテゴリ | ツール |
|---------|-------|
| プラグイン管理 | lazy.nvim |
| LSP / Rust | rustaceanvim + rust-analyzer |
| LSP / C++ | nvim-lspconfig + clangd |
| LSP / Zig | nvim-lspconfig + zls |
| LSP / C# | nvim-lspconfig + csharp-ls |
| 補完 | nvim-cmp + LuaSnip + Copilot |
| ファジーファインダー | Telescope |
| ファイルツリー | neo-tree |
| フォーマッタ | conform.nvim (rustfmt, clang-format, zigfmt, stylua, prettier) |
| 診断 | tiny-inline-diagnostic + Trouble |
| ターミナル | toggleterm.nvim |
| テーマ | One Dark |
| シェル (Linux) | zsh + zinit + Starship |
| ターミナルエミュレータ | WezTerm |

## 必要なもの

### Windows

| ツール | インストール |
|-------|------------|
| Neovim >= 0.11 | `scoop install neovim` |
| Git | `scoop install git` |
| Rust / rustup | [rustup.rs](https://rustup.rs) |
| Node.js | `scoop install nodejs` |
| LLVM (clangd) | `scoop install llvm` |
| Zig | `scoop install zig` |
| zls | `scoop install zls` |
| WezTerm | `scoop install extras/wezterm` |

### Linux

install.sh が自動でインストールしてくれる（apt / dnf / pacman 対応）。

## セットアップ

### Windows（管理者権限の PowerShell で実行）

```powershell
git clone https://github.com/cet-t/dotfiles $HOME\dotfiles
cd $HOME\dotfiles
.\install.ps1
nvim
```

### Linux

```bash
git clone https://github.com/cet-t/dotfiles ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
# 新しいシェルセッションを開く
nvim
```

初回起動時に lazy.nvim が全プラグインを自動インストールする。

## キーバインド

詳細は [keymaps.md](./keymaps.md) を参照。

`<leader>` = `Space`

### 移動・ナビゲーション

| キー | 動作 |
|-----|------|
| `<C-n>` | ファイルツリー toggle |
| `<leader>e` | ファイルツリーにフォーカス / エディタに戻る |
| `<leader>ff` | ファイル検索 |
| `<leader>fg` | 文字列検索（grep）|
| `<leader>fb` | バッファ一覧 |
| `<S-h>` / `<S-l>` | 前 / 次のバッファ |
| `<leader>q` | バッファを閉じる（レイアウト維持）|
| `<C-←↑↓→>` | ウィンドウ間移動 |

### LSP

| キー | 動作 |
|-----|------|
| `gd` | 定義へジャンプ |
| `gr` | 参照一覧 |
| `K` | ホバードキュメント |
| `<leader>ca` | コードアクション |
| `<leader>rn` | リネーム |
| `<leader>f` | フォーマット |
| `[d` / `]d` | 前 / 次のエラー |
| `<leader>d` | エラー詳細フロート |
| `<leader>xx` | Trouble: 診断パネル |

### Rust

| キー | 動作 |
|-----|------|
| `<leader>rr` | Runnables |
| `<leader>rt` | Testables |
| `<leader>re` | マクロ展開 |
| `<leader>rc` | Cargo.toml を開く |

### ターミナル

| キー | 動作 |
|-----|------|
| `<C-\>` | フローティングターミナル toggle |
| `<leader>j` | 下ペインターミナル toggle |

### Copilot

| キー | 動作 |
|-----|------|
| `Alt+l` | インライン補完を確定 |
| `Alt+w` | 単語単位で確定 |
| `Alt+]` / `Alt+[` | 次 / 前の候補 |
