# dotfiles

Neovim 設定 + シェル / ターミナル設定。lazy.nvim + Rust / C++ / Zig / C# / Python / Go / TypeScript 開発環境。

## 構成

| カテゴリ                 | ツール                                                                                                     |
| ------------------------ | ---------------------------------------------------------------------------------------------------------- |
| プラグイン管理           | lazy.nvim                                                                                                  |
| LSP / Rust               | rustaceanvim + rust-analyzer                                                                               |
| LSP / C++                | nvim-lspconfig + clangd                                                                                    |
| LSP / Zig                | nvim-lspconfig + zls                                                                                       |
| LSP / C#                 | nvim-lspconfig + csharp-ls                                                                                 |
| LSP / Python             | nvim-lspconfig + pyright                                                                                   |
| LSP / Go                 | nvim-lspconfig + gopls                                                                                     |
| LSP / TypeScript         | nvim-lspconfig + ts_ls / eslint                                                                            |
| 補完                     | nvim-cmp + LuaSnip + minuet-ai (Codestral)                                                                 |
| AI エージェント          | Claude Code (claude-code.nvim) / OpenCode・Kilocode (toggleterm)                                           |
| ファジーファインダー     | fzf-lua                                                                                                    |
| ファイルエクスプローラ   | fyler.nvim                                                                                                 |
| フォーマッタ             | conform.nvim (rustfmt, clang-format, zigfmt, stylua, taplo, prettier, ruff, goimports, csharpier, xmllint) |
| 診断                     | tiny-inline-diagnostic                                                                                     |
| スクロールバー           | satellite.nvim（git変更・診断・検索マーカー）                                                              |
| 折り畳み                 | nvim-ufo（LSP / indent ベース）                                                                            |
| テキストオブジェクト     | nvim-treesitter-textobjects + vim-expand-region                                                            |
| コンテキスト表示         | nvim-treesitter-context                                                                                    |
| ターミナル               | toggleterm.nvim（Nushell / Kilocode / OpenCode）                                                           |
| バイナリエディタ         | hex.nvim                                                                                                   |
| テーマ                   | bamboo.nvim                                                                                                |
| シェル                   | Nushell                                                                                                    |
| ターミナルエミュレータ   | Rio                                                                                                        |
| ターミナルマルチプレクサ | herdr                                                                                                      |

## ディレクトリ

| パス          | 内容                    | リンク先 (Windows)          |
| ------------- | ----------------------- | --------------------------- |
| `nvim/`       | Neovim 設定             | `%LOCALAPPDATA%\nvim`       |
| `nu/`         | Nushell 設定            | `%APPDATA%\nushell`         |
| `rio/`        | Rio 設定                | `%LOCALAPPDATA%\rio`        |
| `herdr/`      | herdr 設定              | `%APPDATA%\herdr`           |
| `powershell/` | PowerShell プロファイル | -（`install.ps1` の対象外） |

## 必要なもの

`install.ps1` が以下を自動でインストールし、設定をシンボリックリンクする。

| ツール         | インストール方法                           |
| -------------- | ------------------------------------------ |
| scoop          | install.ps1 が自動導入                     |
| Neovim >= 0.12 | `scoop install neovim`                     |
| Git            | `scoop install git`                        |
| Node.js / bun  | `scoop install nodejs bun`                 |
| bat            | `scoop install bat`                        |
| stylua         | `scoop install stylua`                     |
| taplo          | `scoop install taplo`                      |
| prettier       | `npm install -g prettier`                  |
| Rust / rustup  | `winget install Rustlang.Rustup`           |
| ripgrep        | `cargo install ripgrep`                    |
| Rio            | `cargo install rio`                        |
| Nushell        | `cargo install nu`                         |
| herdr          | `irm https://herdr.dev/install.ps1 \| iex` |

LSP / フォーマッタは未インストールなら該当機能が無効になる（実行ファイルが見つかったものだけ有効化）。必要に応じて手動で入れる。

| ツール              | インストール                                                                        |
| ------------------- | ----------------------------------------------------------------------------------- |
| LLVM (clangd)       | `scoop install llvm`                                                                |
| Zig / zls           | `scoop install zig zls`                                                             |
| Go / gopls          | `scoop install go` + `go install golang.org/x/tools/gopls@latest`                   |
| Python / pyright    | `npm install -g pyright` または `pip install pyright`                               |
| ruff                | `scoop install ruff` または `pip install ruff`                                      |
| csharp-ls           | `dotnet tool install -g csharp-ls`                                                  |
| TypeScript / ESLint | `npm install -g typescript-language-server typescript vscode-langservers-extracted` |

## プラグイン一覧

### UI

| プラグイン                          | 説明                                      |
| ----------------------------------- | ----------------------------------------- |
| ribru17/bamboo.nvim                 | カラースキーム                            |
| akinsho/bufferline.nvim             | タブバー                                  |
| famiu/bufdelete.nvim                | レイアウトを維持したバッファ削除          |
| nvim-lualine/lualine.nvim           | ステータスバー（AI spinner 付き）         |
| FylerOrg/fyler.nvim                 | ファイルエクスプローラ（フロートUI）      |
| lukas-reineke/indent-blankline.nvim | インデントガイド                          |
| folke/noice.nvim                    | UI 強化（コマンド・通知・ホバー）         |
| lewis6991/satellite.nvim            | スクロールバー（git・診断・検索マーカー） |
| DaikyXendo/nvim-material-icon       | ファイルアイコン（web-devicons 互換）     |
| rcarriga/nvim-notify                | 通知                                      |

### エディタ

| プラグイン                                  | 説明                                         |
| ------------------------------------------- | -------------------------------------------- |
| ibhagwan/fzf-lua                            | ファジーファインダー（ripgrep / bat 連携）   |
| nvim-treesitter/nvim-treesitter             | シンタックスハイライト・インデント           |
| nvim-treesitter/nvim-treesitter-textobjects | 関数・クラス・引数などのテキストオブジェクト |
| nvim-treesitter/nvim-treesitter-context     | 現在のスコープをバッファ上部に固定表示       |
| terryma/vim-expand-region                   | 選択範囲を段階的に拡大・縮小                 |
| kevinhwang91/nvim-ufo                       | 折り畳み（LSP / indent）                     |
| numToStr/Comment.nvim                       | コメントトグル                               |
| windwp/nvim-autopairs                       | 括弧の自動補完                               |
| folke/which-key.nvim                        | キーバインドヒント                           |
| mrjones2014/smart-splits.nvim               | ウィンドウリサイズ・移動                     |
| lewis6991/gitsigns.nvim                     | git 差分をサインカラムに表示・blame          |
| rachartier/tiny-inline-diagnostic.nvim      | インライン診断表示                           |
| OXY2DEV/markview.nvim                       | Markdown インラインレンダリング              |
| diogo464/hotreload.nvim                     | ファイル変更の自動リロード                   |

### LSP / 補完

| プラグイン                  | 説明                                                               |
| --------------------------- | ------------------------------------------------------------------ |
| neovim/nvim-lspconfig       | LSP クライアント設定（C++ / Zig / C# / Python / Go / TS / ESLint） |
| mrcjkb/rustaceanvim         | Rust LSP（rust-analyzer、clippy on save）                          |
| hrsh7th/nvim-cmp            | 補完エンジン（LSP / LuaSnip / path / buffer）                      |
| L3MON4D3/LuaSnip            | スニペット（friendly-snippets）                                    |
| milanglacier/minuet-ai.nvim | AI インライン補完（Codestral、`CODESTRAL_API_KEY` が必要）         |
| saecki/crates.nvim          | Cargo.toml の依存バージョン表示（autoload 無効）                   |

### ツール

| プラグイン              | 説明                                                       |
| ----------------------- | ---------------------------------------------------------- |
| stevearc/conform.nvim   | フォーマッタ（保存時に自動実行）                           |
| akinsho/toggleterm.nvim | ターミナル（Nushell 水平分割・Kilocode / OpenCode 縦分割） |
| greggh/claude-code.nvim | Claude Code 統合（フロート）                               |
| RaafatTurki/hex.nvim    | バイナリエディタ                                           |

## セットアップ

管理者権限の PowerShell で実行する（Windows のみ対応。`install.sh` は現在メンテナンスしていない）。

```sh
git clone https://github.com/cet-t/dotfiles $HOME\dotfiles
cd $HOME\dotfiles
.\install.ps1
nvim
```

既存の設定は `*.bak` にバックアップされる。

初回起動時に lazy.nvim が全プラグインを自動インストールする。

## キーバインド

詳細は [keymaps.md](./keymaps.md) を参照。

`<leader>` = `Space`

### 基本

| キー        | 動作                     |
| ----------- | ------------------------ |
| `jk`        | インサートモードを抜ける |
| `qq`        | 全て強制終了             |
| `<leader>;` | コマンドモード           |
| `<Esc>`     | 検索ハイライト解除       |

### 移動・ナビゲーション

| キー               | 動作                               |
| ------------------ | ---------------------------------- |
| `-`                | 親ディレクトリを fyler.nvim で開く |
| `<leader>e`        | fyler.nvim フロートで開く          |
| `<leader>ff`       | ファイル検索                       |
| `<leader>fg`       | 文字列検索（grep）                 |
| `<leader>fb`       | バッファ一覧                       |
| `<leader>fh`       | ヘルプ検索                         |
| `<S-h>` / `<S-l>`  | 前 / 次のバッファ                  |
| `<leader>q`        | バッファを閉じる（レイアウト維持） |
| `<C-←↑↓→>`         | ウィンドウ間移動                   |
| `<leader>wh/j/k/l` | ウィンドウリサイズ                 |
| `<leader>w=`       | ウィンドウサイズを均等化           |

### LSP

| キー         | 動作                    |
| ------------ | ----------------------- |
| `gd` / `gD`  | 定義 / 宣言へジャンプ   |
| `gr`         | 参照一覧                |
| `gi`         | 実装へジャンプ          |
| `K`          | ホバードキュメント      |
| `<leader>ca` | コードアクション        |
| `<leader>rn` | リネーム                |
| `<leader>f`  | フォーマット（LSP）     |
| `<leader>cf` | フォーマット（conform） |
| `[d` / `]d`  | 前 / 次のエラー         |
| `<leader>d`  | エラー詳細フロート      |

### 折り畳み・Git

| キー          | 動作                          |
| ------------- | ----------------------------- |
| `zO` / `zC`   | 現在の折り畳みを開く / 閉じる |
| `zOA` / `zCA` | 全て開く / 閉じる             |
| `zP`          | 折り畳み内容をプレビュー      |
| `<leader>gb`  | 行の git blame                |
| `<leader>gB`  | 行 blame 表示 toggle          |
| `<leader>hx`  | Hex 表示 toggle               |

### Rust

| キー         | 動作              |
| ------------ | ----------------- |
| `<leader>rr` | Runnables         |
| `<leader>rt` | Testables         |
| `<leader>rd` | Debuggables       |
| `<leader>re` | マクロ展開        |
| `<leader>rc` | Cargo.toml を開く |

### ターミナル / AI エージェント

| キー         | 動作                                 |
| ------------ | ------------------------------------ |
| `<C-\>`      | ターミナルモードからノーマルモードへ |
| `<leader>j`  | Nushell 水平分割 toggle              |
| `<leader>kt` | Kilocode 縦分割 toggle               |
| `<leader>ot` | OpenCode 縦分割 toggle               |
| `<M-q>`      | Claude Code toggle（フロート）       |
| `<leader>ar` | Claude Code: 前のセッションを再開    |

### Minuet (AI インライン補完)

| キー              | 動作                 |
| ----------------- | -------------------- |
| `<M-l>`           | インライン補完を確定 |
| `<M-w>`           | 行単位で確定         |
| `<M-]>` / `<M-[>` | 次 / 前の候補        |
| `<C-e>`           | 補完を破棄           |

### テキストオブジェクト

| キー                        | 動作                                   |
| --------------------------- | -------------------------------------- |
| `vaf` / `vif`               | 関数全体 / 内部を選択                  |
| `vac` / `vic`               | クラス全体 / 内部を選択                |
| `vaa` / `via`               | 引数全体 / 内部を選択                  |
| `val` / `vil`               | ループ全体 / 内部を選択                |
| `vab` / `vib`               | ブロック全体 / 内部を選択              |
| `]f` / `[f`                 | 次 / 前の関数へ移動                    |
| `]c` / `[c`                 | 次 / 前のクラスへ移動                  |
| `<leader>sn` / `<leader>sp` | 引数を次 / 前と入れ替え                |
| `+` / `_`                   | 選択範囲を拡大 / 縮小（expand-region） |
