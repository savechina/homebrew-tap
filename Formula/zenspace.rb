class Zenspace < Formula
  desc "Zenspace AI Agents productivity suite，个人生产力套件"
  homepage "https://github.com/savechina/zenspace"
  version "0.0.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/savechina/zenspace/releases/download/v0.0.7/zen-aarch64-apple-darwin.tar.xz"
      sha256 "c91f12b572f4ecc711ea916ea03936a1291ab5d46c49688fef73cbefc9329100"
    end
    if Hardware::CPU.intel?
      url "https://github.com/savechina/zenspace/releases/download/v0.0.7/zen-x86_64-apple-darwin.tar.xz"
      sha256 "10bf265c01029bd1a4c516fcfaab82feae56adf7cacd5bda3d3eda9b6a96dae4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/savechina/zenspace/releases/download/v0.0.7/zen-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "251c557347bff0f3731305fa9ec80b2a3bfdcdb666aa512bfc589cb7234c15d7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/savechina/zenspace/releases/download/v0.0.7/zen-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "16feff89b4ed05a982d9b300b2d6e49147c1b9cc67c2507491fe9d7a45aa2a8e"
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
