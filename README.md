# dotfiles

Neovim 設定。lazy.nvim + Rust / C++ / Zig / C# / Python 開発環境。

## 構成

| カテゴリ               | ツール                                                                        |
| ---------------------- | ----------------------------------------------------------------------------- |
| プラグイン管理         | lazy.nvim                                                                     |
| LSP / Rust             | rustaceanvim + rust-analyzer                                                  |
| LSP / C++              | nvim-lspconfig + clangd                                                       |
| LSP / Zig              | nvim-lspconfig + zls                                                          |
| LSP / C#               | nvim-lspconfig + csharp-ls                                                    |
| LSP / Python           | nvim-lspconfig + pyright                                                      |
| 補完                   | nvim-cmp + LuaSnip + Copilot                                                  |
| ファジーファインダー   | Telescope                                                                     |
| ファイルツリー         | neo-tree                                                                      |
| フォーマッタ           | conform.nvim (rustfmt, clang-format, zigfmt, stylua, prettier, ruff)          |
| 診断                   | tiny-inline-diagnostic + Trouble                                              |
| スクロールバー         | satellite.nvim（git変更・診断・検索マーカー）                                 |
| 折り畳み               | nvim-ufo（LSP / treesitter ベース）                                           |
| テキストオブジェクト   | nvim-treesitter-textobjects + targets.vim + nvim-surround + vim-expand-region |
| コンテキスト表示       | nvim-treesitter-context                                                       |
| AI アシスト            | codecompanion.nvim（ローカル LLM / LM Studio 対応）                           |
| バイナリエディタ       | hex.nvim                                                                      |
| ターミナル             | toggleterm.nvim                                                               |
| ファイルアイコン       | nvim-material-icon                                                            |
| テーマ                 | One Dark                                                                      |
| シェル                 | PowerShell (Windows) / zsh + zinit (Linux) + Starship                         |
| ターミナルエミュレータ | Alacritty / WezTerm / Windows Terminal                                        |

## 必要なもの

### Windows

| ツール           | インストール                                          |
| ---------------- | ----------------------------------------------------- |
| Neovim >= 0.12   | `scoop install neovim`                                |
| Git              | `scoop install git`                                   |
| Rust / rustup    | [rustup.rs](https://rustup.rs)                        |
| Node.js          | `scoop install nodejs`                                |
| LLVM (clangd)    | `scoop install llvm`                                  |
| Zig              | `scoop install zig`                                   |
| zls              | `scoop install zls`                                   |
| Python / pyright | `npm install -g pyright` または `pip install pyright` |
| ruff             | `scoop install ruff` または `pip install ruff`        |
| WezTerm          | `scoop install extras/wezterm`                        |
| Alacritty        | `scoop install alacritty`                             |
| taplo (TOML fmt) | `scoop install taplo`                                 |
| stylua (Lua fmt) | `scoop install stylua`                                |

### Linux

install.sh が自動でインストールしてくれる（apt / dnf / pacman 対応）。

## プラグイン一覧

### UI

| プラグイン | 説明 |
| --- | --- |
| navarasu/onedark.nvim | カラースキーム（darker）|
| akinsho/bufferline.nvim | タブバー |
| nvim-lualine/lualine.nvim | ステータスバー |
| nvim-neo-tree/neo-tree.nvim | ファイルツリー |
| lukas-reineke/indent-blankline.nvim | インデントガイド |
| folke/noice.nvim | UI 強化（コマンド・通知・ホバー）|
| lewis6991/satellite.nvim | スクロールバー（git・診断・検索マーカー）|
| nvim-tree/nvim-web-devicons | ファイルアイコン |

### エディタ

| プラグイン | 説明 |
| --- | --- |
| nvim-telescope/telescope.nvim | ファジーファインダー |
| nvim-treesitter/nvim-treesitter | シンタックスハイライト・インデント |
| nvim-treesitter/nvim-treesitter-textobjects | 関数・クラス・引数などのテキストオブジェクト |
| nvim-treesitter/nvim-treesitter-context | 現在のスコープをバッファ上部に固定表示 |
| kylechui/nvim-surround | 括弧・クォートの追加・変更・削除 |
| wellle/targets.vim | 区切り文字テキストオブジェクト拡張 |
| terryma/vim-expand-region | 選択範囲を段階的に拡大・縮小 |
| kevinhwang91/nvim-ufo | 折り畳み（LSP / treesitter）|
| numToStr/Comment.nvim | コメントトグル |
| windwp/nvim-autopairs | 括弧の自動補完 |
| folke/which-key.nvim | キーバインドヒント |
| mrjones2014/smart-splits.nvim | ウィンドウリサイズ・移動 |
| lewis6991/gitsigns.nvim | git 差分をサインカラムに表示 |
| rachartier/tiny-inline-diagnostic.nvim | インライン診断表示 |
| folke/trouble.nvim | 診断パネル |
| MeanderingProgrammer/render-markdown.nvim | Markdown インラインレンダリング |
| iamcco/markdown-preview.nvim | Markdown ブラウザプレビュー |

### LSP / 補完

| プラグイン | 説明 |
| --- | --- |
| neovim/nvim-lspconfig | LSP クライアント設定（C++ / Zig / C# / Python）|
| mrcjkb/rustaceanvim | Rust LSP（rust-analyzer）|
| hrsh7th/nvim-cmp | 補完エンジン |
| L3MON4D3/LuaSnip | スニペット |
| zbirenbaum/copilot.lua | GitHub Copilot インライン補完 |
| zbirenbaum/copilot-cmp | Copilot を nvim-cmp に統合 |
| saecki/crates.nvim | Cargo.toml の依存バージョン補完 |

### ツール

| プラグイン | 説明 |
| --- | --- |
| stevearc/conform.nvim | フォーマッタ（rustfmt / clangd / zigfmt / stylua / prettier / ruff / xmllint）|
| akinsho/toggleterm.nvim | ターミナル（フロート・下ペイン）|
| greggh/claude-code.nvim | Claude Code 統合 |
| olimorris/codecompanion.nvim | ローカル LLM チャット・インライン編集 |
| RaafatTurki/hex.nvim | バイナリエディタ |
| andweeb/presence.nvim | Discord Rich Presence |

## セットアップ

### Windows（管理者権限の PowerShell で実行）

```sh
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

| キー              | 動作                                        |
| ----------------- | ------------------------------------------- |
| `<C-n>`           | ファイルツリー toggle                       |
| `<leader>e`       | ファイルツリーにフォーカス / エディタに戻る |
| `<leader>ff`      | ファイル検索                                |
| `<leader>fg`      | 文字列検索（grep）                          |
| `<leader>fb`      | バッファ一覧                                |
| `<S-h>` / `<S-l>` | 前 / 次のバッファ                           |
| `<leader>q`       | バッファを閉じる（レイアウト維持）          |
| `<C-←↑↓→>`        | ウィンドウ間移動                            |

### LSP

| キー         | 動作                |
| ------------ | ------------------- |
| `gd`         | 定義へジャンプ      |
| `gr`         | 参照一覧            |
| `K`          | ホバードキュメント  |
| `<leader>ca` | コードアクション    |
| `<leader>rn` | リネーム            |
| `<leader>f`  | フォーマット        |
| `[d` / `]d`  | 前 / 次のエラー     |
| `<leader>d`  | エラー詳細フロート  |
| `<leader>xx` | Trouble: 診断パネル |

### Rust

| キー         | 動作              |
| ------------ | ----------------- |
| `<leader>rr` | Runnables         |
| `<leader>rt` | Testables         |
| `<leader>re` | マクロ展開        |
| `<leader>rc` | Cargo.toml を開く |

### ターミナル

| キー        | 動作                            |
| ----------- | ------------------------------- |
| `<C-\>`     | フローティングターミナル toggle |
| `<leader>j` | 下ペインターミナル toggle       |

### Copilot

| キー              | 動作                 |
| ----------------- | -------------------- |
| `Alt+l`           | インライン補完を確定 |
| `Alt+w`           | 単語単位で確定       |
| `Alt+]` / `Alt+[` | 次 / 前の候補        |

### Claude Code

| キー         | 動作                          |
| ------------ | ----------------------------- |
| `<leader>ac` | Claude Code 起動              |
| `<leader>ar` | 前のセッションを再開          |
| `Alt+q`      | ウィンドウ表示 / 非表示トグル |

### テキストオブジェクト

| キー                        | 動作                                   |
| --------------------------- | -------------------------------------- |
| `vaf` / `vif`               | 関数全体 / 内部を選択                  |
| `vac` / `vic`               | クラス全体 / 内部を選択                |
| `vaa` / `via`               | 引数全体 / 内部を選択                  |
| `]f` / `[f`                 | 次 / 前の関数へ移動                    |
| `<leader>sn` / `<leader>sp` | 引数を次 / 前と入れ替え                |
| `ysiw"`                     | 単語を `"` で囲む（surround）          |
| `cs"'`                      | `"` を `'` に変更（surround）          |
| `ds"`                       | `"` を削除（surround）                 |
| `+` / `_`                   | 選択範囲を拡大 / 縮小（expand-region） |

### AI アシスト（codecompanion）

| キー         | 動作                       |
| ------------ | -------------------------- |
| `<leader>ai` | チャットパネル toggle      |
| `<leader>aa` | アクション一覧             |
| `<leader>ae` | インライン編集（選択範囲） |
