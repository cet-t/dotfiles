# List Cargo.toml dependencies (dependencies / dev-dependencies / build-dependencies)
export def cargo-list [] {
  if (not ("Cargo.toml" | path exists)) {
    print "Error: Not found Cargo.toml"
    return
  }

  let toml = (open Cargo.toml)
  let kinds = [
    [key kind];
    [dependencies normal]
    [dev-dependencies dev]
    [build-dependencies build]
  ]

  $kinds | each { |k|
    let deps = ($toml | get --optional $k.key | default {})
    $deps | columns | each { |name|
      let val = ($deps | get $name)
      let is_rec = ($val | describe | str starts-with "record")

      let version = (if $is_rec {
        $val | get --optional version | default (
        if ($val | get --optional path) != null {
          "path"
        } else if ($val | get --optional git) != null {
          "git"
        } else if ($val | get --optional workspace) != null {
          "workspace"
        } else {
          "unknown"
        })
      } else {
        $val
      });

      let features = (if $is_rec {
        $val | get --optional features | default [] | str join ","
      } else {
        ""
      });

      {
        name: $name,
        kind: $k.kind,
        version: $version,
        features: $features,
      }
    }
  } | flatten
}

# Get git diff data
export def git-diff-data [
  --cached,
  --staged(-S),

  --no-cached,
  --no-staged,
] {
  let is_cached = (($cached) or ($staged)) and (not (($no_cached) or ($no_staged)));

  let lines = if ($is_cached) {
    (git diff --numstat --cached)
  } else {
    (git diff --numstat)
  } | from tsv --noheaders;

  if ($lines | is-empty) {
    return
  }

  let diffs = $lines | rename Add Remove Path | each { |r|
    let added = ($r | get Add);
    let removed = ($r | get Remove);

    {
      Add: $"(ansi green)($added)(ansi reset)",
      Remove: $"(ansi red)($removed)(ansi reset)",
      Path: $r.Path
    }
  };

  $diffs
}

# List files and sort by modified
export def ls-sort [dir: directory = .] {
  (ls $dir | sort-by modified)
}

# Check Cargo.toml dependencies
export def cargo-check-deps [] {
    if (not ("Cargo.toml" | path exists)) {
        print "Error: Not found Cargo.toml."
        return
    }

    let deps = (open Cargo.toml | get --optional dependencies)
    if ($deps == null) {
        print "Not registered deps"
        return
    }

    let results = ($deps | columns | each { |crate_name|
        let current_val = ($deps | get $crate_name)
        let current_ver = if ($current_val | describe | str contains "record") {
            $current_val | get --optional version | default "path/git"
        } else {
            $current_val
        }

        let search_res = (cargo search $crate_name --limit 1 err> NUL | lines | first)
        let matched = ($search_res | parse --regex '=\s*"([^"]+)"')
        let latest_ver = if ($matched | is-empty) { 
            "Unknown" 
        } else { 
            $matched | get 0.capture0 
        }
        let status = if $current_ver == $latest_ver { 
          "Up-to-date"
        } else {
          "Update Available"
        }

        {
            Crate: $crate_name,
            Current: $current_ver,
            Latest: $latest_ver,
            Status: $status
        }
    })

    $results
}

# Calculate current directory size
export def dir-size [g: glob = **/*] {
  let dir = (pwd)
  let count = (ls ...(glob $g) | select size | length)
  let size = ((ls ...(glob $g) | get size | math sum))

  {
    dir: $dir,
    files: $count,
    total-size: $size
  }
}

