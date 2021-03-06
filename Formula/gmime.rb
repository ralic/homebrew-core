class Gmime < Formula
  desc "MIME mail utilities"
  homepage "https://spruce.sourceforge.io/gmime/"
<<<<<<< HEAD
  url "https://download.gnome.org/sources/gmime/2.6/gmime-2.6.23.tar.xz"
  sha256 "7149686a71ca42a1390869b6074815106b061aaeaaa8f2ef8c12c191d9a79f6a"

  bottle do
    sha256 "05af2f1ac617529df02b43e6494c480cb442387a96702614ce3eba537d26989a" => :sierra
    sha256 "5b97393ade91622508cd7902a50b2bbeab57d109da9211b6d80053186a84d86a" => :el_capitan
    sha256 "a74503cf97b51a46a7b43f862c1b9cd1f2220b3fc38ba4b56f607b72371f28aa" => :yosemite
  end

  depends_on "pkg-config" => :build
  depends_on "libgpg-error" => :build
=======
  url "https://download.gnome.org/sources/gmime/3.0/gmime-3.0.0.tar.xz"
  sha256 "9d4874fb66d8b09d79ba144d2fbcab6157cf5986268fc4fdc9d98daa12c1a791"

  bottle do
    rebuild 1
    sha256 "229d1fc5ff823df51b6dd040f44de258e8927b9402b484d1ca932f5b59b56628" => :sierra
    sha256 "c8571c9ebfec0c1b958b43e337cf6ac2ab8e0a06a9787763aac67eac22f6f30c" => :el_capitan
    sha256 "cb9b5c435c4c6a8f00251d7551cabafed360fa7e9f10033bb79ab043e8080f96" => :yosemite
  end

  depends_on "pkg-config" => :build
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  depends_on "gobject-introspection" => :recommended
  depends_on "glib"

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --enable-largefile
      --disable-vala
<<<<<<< HEAD
      --disable-mono
=======
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
      --disable-glibtest
    ]

    if build.with? "gobject-introspection"
      args << "--enable-introspection"
    else
      args << "--disable-introspection"
    end
<<<<<<< HEAD
=======

>>>>>>> kettle: fix hardcoded /usr/local idiocy.
    system "./configure", *args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
      #include <stdio.h>
      #include <gmime/gmime.h>
      int main (int argc, char **argv)
      {
<<<<<<< HEAD
        g_mime_init(0);
        if (gmime_major_version>=2) {
=======
        g_mime_init();
        if (gmime_major_version>=3) {
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
          return 0;
        } else {
          return 1;
        }
      }
      EOS
<<<<<<< HEAD
    flags = `pkg-config --cflags --libs gmime-2.6`.split
    system ENV.cc, "-o", "test", "test.c", *(flags + ENV.cflags.to_s.split)
=======
    gettext = Formula["gettext"]
    glib = Formula["glib"]
    pcre = Formula["pcre"]
    flags = (ENV.cflags || "").split + (ENV.cppflags || "").split + (ENV.ldflags || "").split
    flags += %W[
      -I#{gettext.opt_include}
      -I#{glib.opt_include}/glib-2.0
      -I#{glib.opt_lib}/glib-2.0/include
      -I#{include}/gmime-3.0
      -I#{pcre.opt_include}
      -D_REENTRANT
      -L#{gettext.opt_lib}
      -L#{glib.opt_lib}
      -L#{lib}
      -lgio-2.0
      -lglib-2.0
      -lgmime-3.0
      -lgobject-2.0
      -lintl
    ]
    system ENV.cc, "-o", "test", "test.c", *flags
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
    system "./test"
  end
end
