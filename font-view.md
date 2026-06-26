# font-view

```py
import asyncio


def add(a: int, b: int) -> int:
    """a と b の足し算"""
    return a + b


def main() -> None:
    a = 12
    b = 24
    _ = add(a, b)


async def load_async():
    await asyncio.sleep(10)


if __name__ == "__main__":
    main()
```

```rust
use anyhow::Result;
use serde::{Serialize, Deserialize};

#[derive(Debug, Serialize, Deserialize)]
struct User {
    id: u128,
    name: String,
}

fn main() -> Result<()> {
    let user = User {
        id = 0x0001,
        name = "user0",
    };

    let json = serde_json::to_pretty_string(&user)?;
    println!("{}", json);

    let back: User = serde_json::from_string(&json)?;
    println!("{:?}", back)

    Ok(())
}
```

```toml
[package]
name = "font-view"
version = "0.1.0"

[lib]
proc-macro = true
```
