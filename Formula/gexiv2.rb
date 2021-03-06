class Gexiv2 < Formula
  desc "GObject wrapper around the Exiv2 photo metadata library"
  homepage "https://wiki.gnome.org/Projects/gexiv2"
<<<<<<< HEAD
  url "https://download.gnome.org/sources/gexiv2/0.10/gexiv2-0.10.5.tar.xz"
  sha256 "318fe068cd414c0af91759a87c29fd577cd5d42bf7a6f50caff27535c02ac7f3"

  bottle do
    sha256 "32a037cadf438566743c2e2bf9ce5eb964afeba84e95ae9397db10c1f59d6c6e" => :sierra
    sha256 "1d957ba2a091887550e1cc7f72fe61489fb6a9085626486cb1a071bfc9ec169b" => :el_capitan
    sha256 "57c5a3eec78d1091357be4ac89b93847837c592ceb8908d6dd0ba39dfa624d6a" => :yosemite
=======
  url "https://download.gnome.org/sources/gexiv2/0.10/gexiv2-0.10.6.tar.xz"
  sha256 "132788919667254b42c026ab39ab3c3a5be59be8575c05fa4b371ca8aed55825"

  bottle do
    sha256 "8ba4cb6474e1cdc8016a98b882560ce76ace4eba0327b5332d58f879ac3b56e2" => :sierra
    sha256 "675253f04420c2b74c65838d139847253d6e36aaf45f1f1a613c02ca95cbeddf" => :el_capitan
    sha256 "d4c9828f17ea1ea09e124d0e49e96a5483a0fe8226e68f920ea1858f51722ad9" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "pkg-config" => :build
  depends_on "gobject-introspection" => :build
  depends_on "python" if MacOS.version <= :mavericks
  depends_on "glib"
  depends_on "exiv2"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--enable-introspection",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
      #include <gexiv2/gexiv2.h>
      int main() {
        GExiv2Metadata *metadata = gexiv2_metadata_new();
        return 0;
      }
    EOS

    flags = [
      "-I#{HOMEBREW_PREFIX}/include/glib-2.0",
      "-I#{HOMEBREW_PREFIX}/lib/glib-2.0/include",
      "-L#{lib}",
      "-lgexiv2",
    ]

    system ENV.cc, "test.c", "-o", "test", *flags
    system "./test"
  end
end
