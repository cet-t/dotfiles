export-env {
  $env.config.show_banner = false

  $env.PROMPT_COMMAND_RIGHT = {||
    date now | format date "%Y-%m-%d %H:%M:%S"
  }

  $env.config.buffer_editor = "nvim"

  $env.config.table.mode = "psql"
}
