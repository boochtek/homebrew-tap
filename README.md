# BoochTek Homebrew Tap

Custom Homebrew formulas from [BoochTek](https://boochtek.com).

## Installation

```sh
brew tap boochtek/tap
```

## Available Formulas

| Formula | Description |
|---------|-------------|
| [path](https://github.com/boochtek/path-manager) | Easily manipulate your shell PATH |
| lessfilter | Preprocessor for less/lesspipe to handle Markdown files with syntax highlighting |
| terminal-tool | Terminal utilities for window/tab manipulation |

Once the tap is installed, you can install formulas with:

```sh
brew install boochtek/tap/<formula>
```

---

## lessfilter

Preprocessor for `less` that renders Markdown files with syntax highlighting.

### Installation

```sh
brew install boochtek/tap/lessfilter
brew install glow  # recommended
brew install bat   # alternative
```

### Setup

Add to your shell profile (`.bashrc`, `.zshrc`, etc.):

```sh
export LESSOPEN="| /opt/homebrew/bin/lessfilter %s"
```

### Usage

Once configured, simply use `less` to view Markdown files:

```sh
less README.md
```

The file will be rendered with syntax highlighting using `glow` (preferred) or `bat`.

---

## terminal-tool

Terminal utilities for window/tab manipulation.

### Installation

```sh
brew install boochtek/tap/terminal-tool
```

### Commands

#### `terminal title <title>`

Set the terminal window/tab title:

```sh
terminal title "My Project"
```

Works with Terminal.app, iTerm2, and most xterm-compatible terminals.

---

## License

Each formula specifies its own license. See individual formula files for details.

## TODO

- [ ] Rename `path` package to `path-manager`
    - Keep the `path` executable though
    - Update formula name
    - Clarify package name vs executable name in package README and formula
