class Zenspace < Formula
  desc "Zenspace AI Agents productivity suite，个人生产力套件"
  homepage "https://github.com/savechina/zenspace"
  version "0.0.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/savechina/zenspace/releases/download/v0.0.4/zen-aarch64-apple-darwin.tar.xz"
      sha256 "9f7b8493282e326075a7df53232abe3cb5ea9058b0797fa593ca8aca6363a48d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/savechina/zenspace/releases/download/v0.0.4/zen-x86_64-apple-darwin.tar.xz"
      sha256 "c828833ec55b967f42d6931325cfa9f1fad804fdfbdd81120a1ee61ac634034d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/savechina/zenspace/releases/download/v0.0.4/zen-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "87d9067901dc55110d47e4457e82e952924220c5cb3b3f95245a2d8bf1c4e085"
    end
    if Hardware::CPU.intel?
      url "https://github.com/savechina/zenspace/releases/download/v0.0.4/zen-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "679a1e1fd4f3632304b54835517f7784a1f7ea79f4b3e34a9a07b5a4e63c63af"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
