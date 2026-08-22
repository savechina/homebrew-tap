class Zenspace < Formula
  desc "Zenspace AI Agents productivity suite，个人生产力套件"
  homepage "https://github.com/savechina/zenspace"
  version "0.0.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/savechina/zenspace/releases/download/v0.0.8/zen-aarch64-apple-darwin.tar.xz"
      sha256 "e27c4b52e11ccade74d7a6c02a35f256683f9c02d251ad0de9599cde0cd5d4e8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/savechina/zenspace/releases/download/v0.0.8/zen-x86_64-apple-darwin.tar.xz"
      sha256 "83628e0c4d23e6ff9c76075697a4e38e3eba95a343978ef09f7f00eaa6f77caa"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/savechina/zenspace/releases/download/v0.0.8/zen-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d7a6db4667295efa946bfa16609f52ee6778aaa310e58c2a89bbf0ca99e49920"
    end
    if Hardware::CPU.intel?
      url "https://github.com/savechina/zenspace/releases/download/v0.0.8/zen-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "631d29088c877663ad3b6a04ebd4dc73bfd90bc4479c81955b8fe5d69b9a15b7"
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
