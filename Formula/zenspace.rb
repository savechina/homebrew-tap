class Zenspace < Formula
  desc "Zenspace AI Agents productivity suite，个人生产力套件"
  homepage "https://github.com/savechina/zenspace"
  version "0.0.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/savechina/zenspace/releases/download/v0.0.5/zen-aarch64-apple-darwin.tar.xz"
      sha256 "af1f51d0bdf85468f44b7c3b4a150a03153342a016a6477ff7dbcc4a866d680e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/savechina/zenspace/releases/download/v0.0.5/zen-x86_64-apple-darwin.tar.xz"
      sha256 "7c98345ec6e82cc153c02eb23014a1e812502e63964469983525c15838743d6e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/savechina/zenspace/releases/download/v0.0.5/zen-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "97a44b21264e029183f3c63830982c2d332c13cdabee6d40fae0047ea9d4a607"
    end
    if Hardware::CPU.intel?
      url "https://github.com/savechina/zenspace/releases/download/v0.0.5/zen-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "879321f45ed8afdac29d6c7776b1ca4fd3f74e7da61c795d08463da1c7a716aa"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "zen" if OS.mac? && Hardware::CPU.arm?
    bin.install "zen" if OS.mac? && Hardware::CPU.intel?
    bin.install "zen" if OS.linux? && Hardware::CPU.arm?
    bin.install "zen" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
