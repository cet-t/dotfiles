export-env {
  $env.config.show_banner = false

  $env.config.datetime_format = {
    normal: "%Y-%m-%d %H:%M:%S"
    table: "%Y-%m-%d %H:%M:%S"
  }

  $env.config.buffer_editor = "nvim"

  $env.config.table.mode = 'psql'
  $env.config.color_config.datetime = {
    |dt| if $dt > ((date now) - 30day) {
      'gray'
    } else {
      'dark_gray'
    }
  }

  $env.config.color_config.filesize = { 
    |x| if $x == 0b { 
       'dark_gray' 
    } else if $x > 1gb {
      '#ff7e53' 
    } else if $x > 1mb {
      '#ffd83b' 
    } else if $x > 1kb {
      '#badf8f' 
    } else if $x > 0b {
      'dark_gray'
    } else {
      '#ff40ff' # material error
    }
  }

  $env.config.edit_mode = "vi"
  $env.config.cursor_shape = {
    vi_normal: "blink_block"
    vi_insert: "block"
  }

  $env.config.history = {
    file_format: sqlite
    max_size: 1_000
    sync_on_enter: true
    isolation: true
  }

  $env.config.completions = {
    algorithm: fuzzy
  }
}
