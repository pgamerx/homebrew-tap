# typed: strict
# frozen_string_literal: true

# Homebrew formula for Coshift. Lives in github.com/pgamerx/homebrew-tap as Formula/coshift.rb.
# On a new release: bump the version in `url` and set sha256 to the npm tarball's hash
# (curl -sL <url> | shasum -a 256).
class Coshift < Formula
  desc "Shared task board for running Claude Code and Codex accounts on one project"
  homepage "https://github.com/pgamerx/coshift"
  url "https://registry.npmjs.org/coshift/-/coshift-0.6.5.tgz"
  sha256 "7152df1288a3b3ef9770b4ac73e89bbe18f0450aff8c5bf1018897ca7e8144d1"
  license "MIT"

  depends_on "node"
  uses_from_macos "python"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/coshift --version").strip
    assert_match "PostToolUse", shell_output("#{bin}/coshift hook")
    assert_match "Shared task board", shell_output("#{bin}/coshift call help")
  end
end
