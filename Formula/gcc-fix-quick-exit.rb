class GccFixQuickExit < Formula
  desc "Patch Homebrew GCC to fix at_quick_exit/quick_exit on macOS"
  homepage "https://github.com/zippoxer/homebrew-tap"
  url "https://raw.githubusercontent.com/zippoxer/homebrew-tap/main/scripts/gcc-fix-quick-exit.sh"
  sha256 "298bc3db398dfe123ea2ac3cb56b47b72ee2c6b6c28d3ec603f864f8c0536a79"
  license "MIT"
  version "1.0.0"

  depends_on "gcc"
  depends_on :macos

  def install
    bin.install "gcc-fix-quick-exit.sh" => "gcc-fix-quick-exit"
  end

  def post_install
    system "#{bin}/gcc-fix-quick-exit"
  end

  def caveats
    <<~EOS
      The patch has been automatically applied to your GCC installation.

      If you upgrade GCC in the future (brew upgrade gcc), re-apply:
        gcc-fix-quick-exit

      To verify: gcc-fix-quick-exit --check
    EOS
  end

  test do
    system "#{bin}/gcc-fix-quick-exit", "--check"
  end
end
