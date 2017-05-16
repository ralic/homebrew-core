class Fwup < Formula
  desc "Configurable embedded Linux firmware update creator and runner"
  homepage "https://github.com/fhunleth/fwup"
<<<<<<< HEAD
  url "https://github.com/fhunleth/fwup/releases/download/v0.13.0/fwup-0.13.0.tar.gz"
  sha256 "a2b175ae1e0e6235165f1f608fc9cb2b1a1b06bf99cb4dc4d7c5baa7a9007086"

  bottle do
    cellar :any
    sha256 "cb3b5971b6ff3edf5b46cc2a93af8c6ecf88216f173ad316e199acfa18ccbbf7" => :sierra
    sha256 "9a290734145911fbd3fb1a0605d39548433fae65f579fe463514877b1a5acd6d" => :el_capitan
    sha256 "e93b92dc63cc8da05d7639a2714fc74a602b7b058e203009021ed3b8efa6357a" => :yosemite
=======
  url "https://github.com/fhunleth/fwup/releases/download/v0.14.2/fwup-0.14.2.tar.gz"
  sha256 "4ca9ce1c408ca110dfc1de47f0981e052c7da5d11780f7b290056ef4367b28fa"

  bottle do
    cellar :any
    sha256 "8b3000368da1babf1bdd3cc438ab2399acc379a603b0052b958fcf7bb4d8d4af" => :sierra
    sha256 "df20a3a229f35127925ace6d2be0a47213eae8507a84f0ac0b899c77f9780ffb" => :el_capitan
    sha256 "ce59df071c5b40e5019702ce3d3bedfd9a4a88c94f1b032133bc1c08c4472ced" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "pkg-config" => :build
  depends_on "confuse"
  depends_on "libarchive"
  depends_on "libsodium"

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make", "install"
  end

  test do
    system bin/"fwup", "-g"
    assert File.exist?("fwup-key.priv"), "Failed to create fwup-key.priv!"
    assert File.exist?("fwup-key.pub"), "Failed to create fwup-key.pub!"
  end
end
