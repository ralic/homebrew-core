class AtSpi2Atk < Formula
  desc "Accessibility Toolkit GTK+ module"
  homepage "http://a11y.org"
<<<<<<< HEAD
  url "https://download.gnome.org/sources/at-spi2-atk/2.22/at-spi2-atk-2.22.0.tar.xz"
  sha256 "e8bdedbeb873eb229eb08c88e11d07713ec25ae175251648ad1a9da6c21113c1"

  bottle do
    cellar :any
    sha256 "ae9185cac55688d3189fba948f0715ea2fb50e1fe7bd21f7822ac02ef8830ebd" => :sierra
    sha256 "bac769fa1f39e95d37c5abf01d99e1e14e05489d9efd6e19415d07d81f2bd2cd" => :el_capitan
    sha256 "c1a1dd0a265a8b2a4ce9630c3408350459980e7e9258eb35bea3896e4e289805" => :yosemite
=======
  url "https://download.gnome.org/sources/at-spi2-atk/2.24/at-spi2-atk-2.24.1.tar.xz"
  sha256 "60dc90ac4f74b8ffe96a9363c25208a443b381bacecfefea6de549f20ed6957d"

  bottle do
    cellar :any
    sha256 "44d6a555162dea2049305e93f37f8537097bcd4db382a33c46f0cb41a01f41d3" => :sierra
    sha256 "8fec3a70477bdcf8381f08decf4dbac2f33c991233c840f24e42cf11164a134b" => :el_capitan
    sha256 "90c79a2b1a7e4b9e929c43d8de86fb66b17799fa8bf6334b7f64098c47bff262" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "pkg-config" => :build
  depends_on "at-spi2-core"
  depends_on "atk"

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end
end
