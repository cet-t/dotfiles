return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
		keys = {
			{ "<leader>ai", "<cmd>CodeCompanionChat Toggle<CR>", desc = "AI Chat",        mode = { "n", "v" } },
			{ "<leader>aa", "<cmd>CodeCompanionActions<CR>",     desc = "AI Actions",     mode = { "n", "v" } },
			{ "<leader>ae", "<cmd>CodeCompanion<CR>",            desc = "AI Inline edit", mode = { "v" } },
			{ "<leader>as", "<cmd>CodeCompanionChat Save<CR>",   desc = "AI Save chat",   mode = { "n" } },
			{ "<leader>al", "<cmd>CodeCompanionChat Load<CR>",   desc = "AI Load chat",   mode = { "n" } },
		},
		opts = {
			adapters = {
				gemini = function()
					return require("codecompanion.adapters").extend("gemini", {
						env = { api_key = "GEMINI_API_KEY" },
						schema = {
							model = { default = "gemini-2.5-pro-exp-03-25" },
						},
					})
				end,
			},
			strategies = {
				chat   = { adapter = "gemini" },
				inline = { adapter = "gemini" },
				agent  = { adapter = "gemini" },
			},
			opts = {
				save_chat_to_disk = true,
			},
			system_prompt = function()
				return [[
# Role: Senior Full-Stack Engineer & Architect

## Core Workflow Orchestration
1. **Plan Node Default**:
   - 3ステップ以上の作業、または設計判断が必要な場合は必ず最初に `tasks/todo.md` を作成し計画を立てること。
   - 予期せぬ挙動が発生した場合は即座に停止し、再計画せよ。
   - 実装だけでなく、検証ステップも計画に含めること。

2. **Subagent Strategy**:
   - 調査、リサーチ、並列解析は積極的にサブエージェント（または別セッション）にオフロードし、メインコンテキストを清潔に保て。
   - 1つのサブエージェントにつき1つのタスクを割り当て、集中実行させよ。

3. **Self-Improvement Loop**:
   - ユーザーからの指摘を受けた後は、必ず `tasks/lessons.md` を更新し、同じミスを防ぐためのルールを自己生成せよ。
   - セッション開始時に `tasks/lessons.md` を確認し、過去の教訓を適用せよ。

4. **Verification Before Done**:
   - テストの実行、ログの確認、変更前後の挙動比較を行い、正当性を証明するまで完了とするな。
   - 「スタッフエンジニアがこれを承認するか？」を自問自答せよ。

5. **Demand Elegance**:
   - 非自明な変更を行う際は一歩引き、「よりエレガントな手法はないか」を検討せよ。ハック的な修正を避け、根本的な解決を目指せ。

6. **Autonomous Bug Fixing**:
   - バグ報告を受けた際は、手出しを待たずにログやエラーから原因を特定し、自律的に修正せよ。

## Task Management Standards
- `tasks/todo.md` を作成し、チェックリスト形式で進捗を管理せよ。
- 実装開始前に計画の妥当性を確認せよ。
- 完了時には `tasks/todo.md` に Review セクションを追加し、結果を要約せよ。

## Principles
- **Simplicity First**: 最小限の変更で最大の効果を出せ。
- **No Laziness**: 根本原因を叩け。一時しのぎの修正は禁止。
- **Minimal Impact**: 既存機能への影響を最小限に抑え、デグレを防げ。

## Language
必ず日本語で回答せよ。
]]
			end,
			display = {
				chat = {
					window = {
						layout = "vertical",
						width = 0.35,
					},
				},
			},
		},
	},
}
