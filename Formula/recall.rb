class Recall < Formula
  desc "Search and resume your Claude Code and Codex CLI conversations"
  homepage "https://github.com/zippoxer/recall"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/zippoxer/recall/releases/download/v#{version}/recall-macos-intel.tar.gz"
      sha256 "98f2db4380d81fe7a5c0d6bbbe46de36374719f3f120588cb17b7c58e13940b8"
    end

    on_arm do
      url "https://github.com/zippoxer/recall/releases/download/v#{version}/recall-macos-arm64.tar.gz"
      sha256 "7b5ec97e75df6eb901e030295a2d51c9b23e84635b8056fd470d3495056e7586"
    end
  end

  on_linux do
    url "https://github.com/zippoxer/recall/releases/download/v#{version}/recall-linux-x86_64.tar.gz"
    sha256 "92a5b6ee91a7b06030cf2200a6df88d25c042f470024c0274326e4f6d9ccfc01"
  end

  def install
    bin.install "recall"
  end

  test do
    assert_match "recall", shell_output("#{bin}/recall --help 2>&1", 1)
  end
end
