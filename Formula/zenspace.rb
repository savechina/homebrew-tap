class Zenspace < Formula
  desc "Zenspace AI Agents productivity suite，个人生产力套件"
  homepage "https://github.com/savechina/zenspace"
  version "0.0.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/savechina/zenspace/releases/download/v0.0.6/zen-aarch64-apple-darwin.tar.xz"
      sha256 "12273aaef49ee76c00bb1201fa00d84a9bfe7e839a197509032a49b99d09ae5f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/savechina/zenspace/releases/download/v0.0.6/zen-x86_64-apple-darwin.tar.xz"
      sha256 "b0a9bd6f1653b90a958e41d34a1973cc039a87ab7b07acf32054251666a04cdb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/savechina/zenspace/releases/download/v0.0.6/zen-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dfdeb1f04e38ba322a8f7e9e33f54a1d5d82518d4059d3f3513ae1c8720effa0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/savechina/zenspace/releases/download/v0.0.6/zen-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "778ea8a0b48a31781c016931b38990c746eb032311a9354a28ee16e97ce8be62"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "zen"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "zen"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "zen"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "zen"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
