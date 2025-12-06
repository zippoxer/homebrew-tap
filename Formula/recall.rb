class Recall < Formula
  desc "Search and resume your Claude Code and Codex CLI conversations"
  homepage "https://github.com/zippoxer/recall"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/zippoxer/recall/releases/download/v#{version}/recall-macos-intel.tar.gz"
      sha256 "9935819070af086d23b5539f51e0dcca41686c641df80d686d06f5bfee4d082b"
    end

    on_arm do
      url "https://github.com/zippoxer/recall/releases/download/v#{version}/recall-macos-arm64.tar.gz"
      sha256 "1b273ff645994b254fd0fc10cca12c455b50143a5bfd51ba69803b61aa6c821c"
    end
  end

  on_linux do
    url "https://github.com/zippoxer/recall/releases/download/v#{version}/recall-linux-x86_64.tar.gz"
    sha256 "e4dcdd469e9feb99e20de18bcb514367fc83605eff9515e3594f384f0f76effa"
  end

  def install
    bin.install "recall"
  end

  test do
    assert_match "recall", shell_output("#{bin}/recall --help")
  end
end
