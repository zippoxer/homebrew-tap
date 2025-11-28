class Recall < Formula
  desc "Search and resume your Claude Code and Codex CLI conversations"
  homepage "https://github.com/zippoxer/recall"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/zippoxer/recall/releases/download/v#{version}/recall-macos-intel.tar.gz"
      sha256 "e5a3e81e7f19785de2a370895d345ca010d51d85105b71f9fe6cf6ebba8ce7cf"
    end

    on_arm do
      url "https://github.com/zippoxer/recall/releases/download/v#{version}/recall-macos-arm64.tar.gz"
      sha256 "874fe3619ac207faa2362cc3ea9fe2e9121239e261189fcf64817c50a12780cd"
    end
  end

  on_linux do
    url "https://github.com/zippoxer/recall/releases/download/v#{version}/recall-linux-x86_64.tar.gz"
    sha256 "df752eb0ccfe3b5a2fe14db1e453364b6477271381f5a7a8a1778758ff9791af"
  end

  def install
    bin.install "recall"
  end

  test do
    assert_match "recall", shell_output("#{bin}/recall --help 2>&1", 1)
  end
end
