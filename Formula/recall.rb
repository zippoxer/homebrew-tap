class Recall < Formula
  desc "Search and resume your Claude Code and Codex CLI conversations"
  homepage "https://github.com/zippoxer/recall"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/zippoxer/recall/releases/download/v#{version}/recall-macos-intel.tar.gz"
      sha256 "46c3360536b86a5fbf3570460141769b3492c9d3ae6d2c693bb85cd2404f14c4"
    end

    on_arm do
      url "https://github.com/zippoxer/recall/releases/download/v#{version}/recall-macos-arm64.tar.gz"
      sha256 "9c8c167d8d625adf847824dc4b56c40f41cd0e19ccf0524defd13023f03c21a6"
    end
  end

  on_linux do
    url "https://github.com/zippoxer/recall/releases/download/v#{version}/recall-linux-x86_64.tar.gz"
    sha256 "b7487783ecf5350718a7217350794eecc90d4bd27f6654fafc9a02e1b91101d2"
  end

  def install
    bin.install "recall"
  end

  test do
    assert_match "recall", shell_output("#{bin}/recall --help 2>&1", 1)
  end
end
