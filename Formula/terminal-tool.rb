class TerminalTool < Formula

  desc "Terminal utilities for window/tab manipulation, badges, notifications, and more"
  homepage "https://github.com/boochtek/terminal-tool"
  url "https://github.com/boochtek/terminal-tool/archive/refs/tags/v0.9.1.tar.gz"
  sha256 "38f5bfaa47a877289cd059b22a4ec1f02416f35141bcc51672fc9845dfba9ead"
  license "MIT"

  depends_on "bats-core" => :test
  depends_on "terminal-notifier" => :recommended

  def install
    bin.install "terminal.sh" => "terminal"
  end

  def caveats
    <<~EOS
      Usage:
        terminal <command> [args]

      Commands:
        title <text>           Set window/tab title
        badge <text>           Set iTerm2 badge (corner watermark)
        reset                  Reset terminal state
        notify <message>       Send notification
        cwd [directory]        Set working directory for new tabs
        profile <name>         Switch iTerm2 profile
        mark                   Set navigation mark
        attention              Request attention (bounce dock)
        progress <0-100|done>  Show progress in tab bar
        info                   Show terminal information
        colors                 Display color palette
        cursor <style>         Change cursor style
        clipboard get|set      Access system clipboard
        image <file>           Display inline image
        link <url> [text]      Create clickable hyperlink

      Run 'terminal --help' for more information.
    EOS
  end

  test do
    assert_predicate bin / "terminal", :exist?
    assert_predicate bin / "terminal", :executable?

    # Basic syntax check
    system "bash", "-n", bin / "terminal"

    # Version check
    assert_match "0.9.1", shell_output("#{bin}/terminal --version")

    # Help check (exits 0 for --help)
    output = shell_output("#{bin}/terminal --help")
    assert_match "Usage:", output
    assert_match "title", output
    assert_match "badge", output

    # Test commands exist (usage errors)
    shell_output("#{bin}/terminal title", 1)
    shell_output("#{bin}/terminal badge", 1)
    shell_output("#{bin}/terminal cursor", 1)
  end

end
