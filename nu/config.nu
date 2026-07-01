# config.nu
#
# Installed by:
# version = "0.111.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

# --- Aliases ---

alias nv = nvim

# ---------------

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
    '#bababa'
  } else {
    '#ff40ff' # material error
  }
}

$env.config.edit_mode = "vi"
$env.config.cursor_shape = {
  vi_normal: "line"
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
