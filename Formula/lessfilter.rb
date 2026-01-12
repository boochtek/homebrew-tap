class Lessfilter < Formula

  desc "Preprocessor for less/lesspipe to handle Markdown files with syntax highlighting"
  homepage "https://github.com/boochtek/homebrew-tap"
  url "https://github.com/boochtek/homebrew-tap/archive/refs/heads/main.tar.gz"
  version "1.0.0"
  license "MIT"

  def install
    # Create the lessfilter script
    (bin / "lessfilter").write <<~'BASH'
      #!/bin/bash
      # lessfilter - preprocessor for lesspipe.sh

      case "$1" in
          *.md|*.MD|*.mkd|*.markdown)
              if command -v glow >/dev/null 2>&1; then
                  # NOTE: Glow needs the CLICOLOR_FORCE to enable color output to a non-TTY.
                  # NOTE: Glow won't output color to a non-TTY if style is set to `auto`.
                  CLICOLOR_FORCE=1 glow --style=light "$1"
                  exit 0
              elif command -v bat >/dev/null 2>&1; then
                  bat --color=always --style=plain "$1"
                  exit 0
              fi
              ;;
      esac

      exit 1
    BASH

    chmod 0o755, bin / "lessfilter"
  end

  def caveats
    <<~EOS
      To use lessfilter with less, add the following to your shell profile:

        export LESSOPEN="| #{opt_bin}/lessfilter %s"

      For zsh users, you can also add this to your shell profile:

        export LESSOPEN="| #{opt_bin}/lessfilter %s"
        export LESS='--IGNORE-CASE --LONG-PROMPT --RAW-CONTROL-CHARS --chop-long-lines --tabs=4'

      Then restart your shell or source your profile.

      Note: lessfilter uses glow (preferred) or bat for Markdown syntax highlighting.
      Install them with:
        brew install glow bat
    EOS
  end

  test do
    # Test that the script exists and is executable
    assert_predicate bin / "lessfilter", :exist?
    assert_predicate bin / "lessfilter", :executable?

    # Basic syntax check
    system "bash", "-n", bin / "lessfilter"

    # Test with a non-markdown file (should exit 1)
    system bin / "lessfilter", "/dev/null"
    assert_equal 1, $?.exitstatus
  end

end
