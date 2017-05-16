class Freetype < Formula
  desc "Software library to render fonts"
  homepage "https://www.freetype.org/"
<<<<<<< HEAD
  url "https://downloads.sourceforge.net/project/freetype/freetype2/2.7.1/freetype-2.7.1.tar.bz2"
  mirror "https://download.savannah.gnu.org/releases/freetype/freetype-2.7.1.tar.bz2"
  sha256 "3a3bb2c4e15ffb433f2032f50a5b5a92558206822e22bfe8cbe339af4aa82f88"

  bottle do
    cellar :any
    sha256 "13627ffdf46a1236bc702b1656f1fc8d95a503b515ff1b212bb4d1851d19e097" => :sierra
    sha256 "63f3945987b8dc90dc6bf456f5406b2ba70160a80a65c94caaeb2b3e0c04b2d3" => :el_capitan
    sha256 "14588ddd46a90c9df9591d1cff02953bc639b96ffec0e8274ab7703f4b9361b2" => :yosemite
=======
  url "https://downloads.sourceforge.net/project/freetype/freetype2/2.8/freetype-2.8.tar.bz2"
  mirror "https://download.savannah.gnu.org/releases/freetype/freetype-2.8.tar.bz2"
  sha256 "a3c603ed84c3c2495f9c9331fe6bba3bb0ee65e06ec331e0a0fb52158291b40b"

  bottle do
    cellar :any
    sha256 "f22537dd3f8b5638a712c7a6231f0b57359c4adef0557b6e90b92e11d930640f" => :sierra
    sha256 "0a83ce9cb40656fd438a5475a09331c4bcc9a0e771af0d6049f002d14f02f576" => :el_capitan
    sha256 "37d29dac299114d75abfcc1a75c6e10e1ce602072da732298a2a64438a3cedc3" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  keg_only :provided_pre_mountain_lion

  option "without-subpixel", "Disable sub-pixel rendering (a.k.a. LCD rendering, or ClearType)"

  depends_on "libpng"

  def install
    if build.with? "subpixel"
      inreplace "include/freetype/config/ftoption.h",
          "/* #define FT_CONFIG_OPTION_SUBPIXEL_RENDERING */",
          "#define FT_CONFIG_OPTION_SUBPIXEL_RENDERING"
    end

    system "./configure", "--prefix=#{prefix}", "--without-harfbuzz"
    system "make"
    system "make", "install"

    inreplace [bin/"freetype-config", lib/"pkgconfig/freetype2.pc"],
      prefix, opt_prefix
  end

  test do
    system bin/"freetype-config", "--cflags", "--libs", "--ftversion",
                                  "--exec-prefix", "--prefix"
  end
end
