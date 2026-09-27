class Zenspace < Formula
  desc "Zenspace AI Agents productivity suite，个人生产力套件"
  homepage "https://github.com/savechina/zenspace"
  version "0.0.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/savechina/zenspace/releases/download/v0.0.9/zen-aarch64-apple-darwin.tar.xz"
      sha256 "8cab95d45d370cb10346e23ebe95acfaed9f2ae983229e0520bcbb37e4de0524"
    end
    if Hardware::CPU.intel?
      url "https://github.com/savechina/zenspace/releases/download/v0.0.9/zen-x86_64-apple-darwin.tar.xz"
      sha256 "6824a57091dc7cb9362a35003cba5fe2762c70e7f3442dfb488dd583add2966f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/savechina/zenspace/releases/download/v0.0.9/zen-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "25a2a4df10368ebfa87ee3db341afc66ea7ce4b7def9bbdb5df928877c4db7f5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/savechina/zenspace/releases/download/v0.0.9/zen-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dda517525eabbb0ca423ced046e9f90ca9c498b141a2468613e436ae88ac7f71"
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
