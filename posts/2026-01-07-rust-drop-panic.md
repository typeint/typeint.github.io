# Rust Drop

Hello!
My first post here.
For the first post I'll write about something neat I learned today.
The Rust destructors are always called even if your code panics.
Like here the `drop()` still runs your code panics.

```rust
struct S;

impl Drop for S {
    fn drop(&mut self) {
        println!("dropped");
    }
}

fn main() {
    let _s = S;
    panic!("boom");
}
```

When you run this, you'll see:

```
thread 'main' panicked at src/main.rs:11:5:
boom
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
dropped
```

The panic happens, but Rust still calls `drop()` on `_s` first.
There is one important caveat.
This only works during normal unwinding.
If you compile with `panic = "abort"`, Rust skips unwinding and just terminates the process.
I mean, don't put this in your `Cargo.toml`:

```toml
[profile.dev]
panic = "abort"
```

If you put that, you'll see:

```
thread 'main' panicked at src/main.rs:11:5:
boom
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
zsh: abort      cargo run
```

So the `drop()` is skipped.
That's it. That wraps up my first post!

