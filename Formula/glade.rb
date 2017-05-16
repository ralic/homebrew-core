class Glade < Formula
  desc "RAD tool for the GTK+ and GNOME environment"
  homepage "https://glade.gnome.org/"
  url "https://download.gnome.org/sources/glade/3.20/glade-3.20.0.tar.xz"
  sha256 "82d96dca5dec40ee34e2f41d49c13b4ea50da8f32a3a49ca2da802ff14dc18fe"
  revision 1

  bottle do
<<<<<<< HEAD
    sha256 "5ce422e93894c6136ef3df57e8440c482c0bfac5277a41ed8f2fc79879caec86" => :sierra
    sha256 "93e1cacb5f672dd4913191e16f81a6c24ca45943faf7493f7b0b0363dbfe69d6" => :el_capitan
    sha256 "97be70ab4496c03f9fae820dffaaa5fcc9c1d3399adbe797bbe52e50ab1aad76" => :yosemite
=======
    rebuild 1
    sha256 "01d2d5d6277b331485281d6668d5a2494367813a7cf09e4eb3670955ace238aa" => :sierra
    sha256 "420cee7949561ae0c5ed7d5c7472a83b655d8dc427bdf965b49d7e989c71fe4e" => :el_capitan
    sha256 "8c9c09600f97e65562ac8afc4eebe3a66a8122db850f86aacc65195e4f97ccfd" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on "itstool" => :build
  depends_on "docbook-xsl" => :build
  depends_on "gettext"
  depends_on "libxml2"
  depends_on "gnome-icon-theme"
  depends_on "hicolor-icon-theme"
  depends_on "gtk+3"
  depends_on "gtk-mac-integration"

  def install
    # Find our docbook catalog
    ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog"

    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-gladeui",
                          "--enable-introspection"
    # objective-c is needed for glade-registration.c. unfortunately build fails if -x objective-c is added to global CFLAGS.
    # Bugreport Upstream: https://bugzilla.gnome.org/show_bug.cgi?id=768032
    inreplace "src/Makefile", "-c -o glade-glade-registration.o", "-x objective-c -c -o glade-glade-registration.o"

    system "make" # separate steps required
    system "make", "install"
  end

  test do
    # executable test (GUI)
    system "#{bin}/glade", "--version"
    # API test
    (testpath/"test.c").write <<-EOS.undent
      #include <gladeui/glade.h>

      int main(int argc, char *argv[]) {
        gboolean glade_util_have_devhelp();
        return 0;
      }
    EOS
    ENV.libxml2
    atk = Formula["atk"]
    cairo = Formula["cairo"]
    fontconfig = Formula["fontconfig"]
    freetype = Formula["freetype"]
    gdk_pixbuf = Formula["gdk-pixbuf"]
    gettext = Formula["gettext"]
    glib = Formula["glib"]
<<<<<<< HEAD
    gtkx = Formula["gtk+3"]
    libpng = Formula["libpng"]
    pango = Formula["pango"]
    pixman = Formula["pixman"]
    flags = %W[
=======
    gtkx3 = Formula["gtk+3"]
    harfbuzz = Formula["harfbuzz"]
    libepoxy = Formula["libepoxy"]
    libpng = Formula["libpng"]
    pango = Formula["pango"]
    pcre = Formula["pcre"]
    pixman = Formula["pixman"]
    flags = (ENV.cflags || "").split + (ENV.cppflags || "").split + (ENV.ldflags || "").split
    flags += %W[
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
      -I#{atk.opt_include}/atk-1.0
      -I#{cairo.opt_include}/cairo
      -I#{fontconfig.opt_include}
      -I#{freetype.opt_include}/freetype2
      -I#{gdk_pixbuf.opt_include}/gdk-pixbuf-2.0
      -I#{gettext.opt_include}
<<<<<<< HEAD
      -I#{glib.opt_include}/glib-2.0
      -I#{glib.opt_lib}/glib-2.0/include
      -I#{gtkx.opt_include}/gtk-3.0
      -I#{gtkx.opt_lib}/gtk-3.0/include
      -I#{include}/libgladeui-2.0
      -I#{libpng.opt_include}/libpng16
      -I#{pango.opt_include}/pango-1.0
=======
      -I#{glib.opt_include}/gio-unix-2.0/
      -I#{glib.opt_include}/glib-2.0
      -I#{glib.opt_lib}/glib-2.0/include
      -I#{gtkx3.opt_include}/gtk-3.0
      -I#{harfbuzz.opt_include}/harfbuzz
      -I#{include}/libgladeui-2.0
      -I#{libepoxy.opt_include}
      -I#{libpng.opt_include}/libpng16
      -I#{pango.opt_include}/pango-1.0
      -I#{pcre.opt_include}
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
      -I#{pixman.opt_include}/pixman-1
      -D_REENTRANT
      -L#{atk.opt_lib}
      -L#{cairo.opt_lib}
      -L#{gdk_pixbuf.opt_lib}
      -L#{gettext.opt_lib}
      -L#{glib.opt_lib}
<<<<<<< HEAD
      -L#{gtkx.opt_lib}
=======
      -L#{gtkx3.opt_lib}
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
      -L#{lib}
      -L#{pango.opt_lib}
      -latk-1.0
      -lcairo
<<<<<<< HEAD
      -lgdk-quartz-2.0
=======
      -lcairo-gobject
      -lgdk-3
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
      -lgdk_pixbuf-2.0
      -lgio-2.0
      -lgladeui-2
      -lglib-2.0
      -lgobject-2.0
<<<<<<< HEAD
      -lgtk-quartz-2.0
=======
      -lgtk-3
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
      -lintl
      -lpango-1.0
      -lpangocairo-1.0
      -lxml2
    ]
    system ENV.cc, "test.c", "-o", "test", *flags
    system "./test"
  end
end
