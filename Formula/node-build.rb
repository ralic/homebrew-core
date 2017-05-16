class NodeBuild < Formula
  desc "Install NodeJS versions"
  homepage "https://github.com/nodenv/node-build"
<<<<<<< HEAD
  url "https://github.com/nodenv/node-build/archive/v2.5.11.tar.gz"
  sha256 "19db264e995d97098e1f7bf451edd93d9e1d89ccdf5bc3012cd49767d1d7d8cb"
=======
  url "https://github.com/nodenv/node-build/archive/v2.5.12.tar.gz"
  sha256 "f40e675d519ea7eaa581b5b59f1c2835243926e01dc943a3a6019ab8b80c5e27"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/nodenv/node-build.git"

  bottle :unneeded

  depends_on "autoconf" => [:recommended, :run]
  depends_on "pkg-config" => [:recommended, :run]
  depends_on "openssl" => :recommended

  def install
    ENV["PREFIX"] = prefix
    system "./install.sh"
  end

  test do
    system "#{bin}/node-build", "--definitions"
  end
end
