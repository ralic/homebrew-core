class Libvorbis < Formula
  desc "Vorbis General Audio Compression Codec"
  homepage "http://vorbis.com/"
  url "http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.5.tar.xz"
  sha256 "54f94a9527ff0a88477be0a71c0bab09a4c3febe0ed878b24824906cd4b0e1d1"
<<<<<<< HEAD

  bottle do
    cellar :any
    sha256 "db1a358423016b9c2f64fac76e7e3f881ba2e33fe1d802f14a99fae781a0d825" => :sierra
    sha256 "e0bf33971c2a59b9503b8f39f68a1aa44e25dd292d610d77508015638170e274" => :el_capitan
    sha256 "cf396496dc6daea304bb81e9e099831c97bf6756ac91954c26993cbb39bc97c2" => :yosemite
    sha256 "9e042bea299b9fb2dcc7bac8140ae3544d1bbe74a8ce3b6204836d2704f641bf" => :mavericks
    sha256 "0f9ad569a98c521e28447cd85ecc18e7a4a61585564d86251d3225b0099f84aa" => :mountain_lion
  end

  head do
    url "https://svn.xiph.org/trunk/vorbis"
=======
  revision 1

  bottle do
    cellar :any
    sha256 "bb0732d6af0d2a9cdf1004ebbf48da1758cfac1fbb65cfbb91d0bbf936d7d596" => :sierra
    sha256 "8a0b39934d086a5be7d7daede5807bd99baf0d9f5ce5dc860abcec3427c32a44" => :el_capitan
    sha256 "e3892e6523bc1411f5b164b7c64f392897c7735894aa654688cd904d4cfaa3b2" => :yosemite
  end

  head do
    url "https://git.xiph.org/vorbis.git"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "libogg"

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
