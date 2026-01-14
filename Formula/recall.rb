class Recall < Formula
  desc "Search and resume your Claude Code and Codex CLI conversations"
  homepage "https://github.com/zippoxer/recall"
  version "0.5.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/zippoxer/recall/releases/download/v#{version}/recall-macos-intel.tar.gz"
      sha256 "2f02f25b823db4489688019af5afd77308b01794f7cc7b215897ba748d2cc631"
    end

    on_arm do
      url "https://github.com/zippoxer/recall/releases/download/v#{version}/recall-macos-arm64.tar.gz"
      sha256 "1adacf048e8f042cc789a3d4f4e6c427fa73e62f921a0a48b5cc30708830a129"
    end
  end

  on_linux do
    url "https://github.com/zippoxer/recall/releases/download/v#{version}/recall-linux-x86_64.tar.gz"
    sha256 "86aee348b5a15f2aa18d8c6536d65089e8fcf68ff43b46fefc56f3ab5e791e16"
  end

  def install
    bin.install "recall"
  end

  test do
    assert_match "recall", shell_output("#{bin}/recall --help")
  end
end
