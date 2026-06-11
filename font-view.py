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
