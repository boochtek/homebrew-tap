class TerminalTool < Formula

  desc "Terminal utilities for window/tab manipulation"
  homepage "https://github.com/boochtek/homebrew-tap"
  url "https://github.com/boochtek/homebrew-tap/archive/refs/heads/main.tar.gz"
  version "1.0.0"
  license "MIT"

  def install
    (bin / "terminal").write <<~'BASH'
      #!/bin/bash
      # terminal - terminal utilities

      usage() {
          echo "Usage: terminal <command> [args]" >&2
          echo "" >&2
          echo "Commands:" >&2
          echo "  title <title>  Set the terminal window/tab title" >&2
          exit 1
      }

      cmd_title() {
          if [[ $# -eq 0 ]]; then
              echo "Usage: terminal title <title>" >&2
              exit 1
          fi
          # OSC 0 sets both window and icon title
          # Works with xterm, iTerm2, Terminal.app, and most modern terminals
          printf '\033]0;%s\007' "$*"
      }

      [[ $# -eq 0 ]] && usage

      command="$1"
      shift

      case "$command" in
          title)
              cmd_title "$@"
              ;;
          *)
              echo "Unknown command: $command" >&2
              usage
              ;;
      esac
    BASH

    chmod 0o755, bin / "terminal"
  end

  def caveats
    <<~EOS
      Usage:
        terminal title My Project

      This sets the terminal window/tab title using standard escape sequences.
      Works with Terminal.app, iTerm2, and most xterm-compatible terminals.
    EOS
  end

  test do
    assert_predicate bin / "terminal", :exist?
    assert_predicate bin / "terminal", :executable?

    # Basic syntax check
    system "bash", "-n", bin / "terminal"

    # Test with no arguments (should exit 1)
    system bin / "terminal"
    assert_equal 1, $CHILD_STATUS.exitstatus

    # Test title with no arguments (should exit 1)
    system bin / "terminal", "title"
    assert_equal 1, $CHILD_STATUS.exitstatus
  end

end
