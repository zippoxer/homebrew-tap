class Recall < Formula
  desc "Search and resume your Claude Code and Codex CLI conversations"
  homepage "https://github.com/zippoxer/recall"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/zippoxer/recall/releases/download/v#{version}/recall-macos-intel.tar.gz"
      sha256 "PLACEHOLDER_INTEL_SHA256"
    end

    on_arm do
      url "https://github.com/zippoxer/recall/releases/download/v#{version}/recall-macos-arm64.tar.gz"
      sha256 "PLACEHOLDER_ARM64_SHA256"
    end
  end

  on_linux do
    url "https://github.com/zippoxer/recall/releases/download/v#{version}/recall-linux-x86_64.tar.gz"
    sha256 "PLACEHOLDER_LINUX_SHA256"
  end

  def install
    bin.install "recall"
  end

  test do
    assert_match "recall", shell_output("#{bin}/recall --help 2>&1", 1)
  end
end
