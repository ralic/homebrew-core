class Pcre2 < Formula
  desc "Perl compatible regular expressions library with a new API"
  homepage "http://www.pcre.org/"
<<<<<<< HEAD
  url "https://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre2-10.23.tar.bz2"
  mirror "https://www.mirrorservice.org/sites/ftp.exim.org/pub/pcre/pcre2-10.23.tar.bz2"
  sha256 "dfc79b918771f02d33968bd34a749ad7487fa1014aeb787fad29dd392b78c56e"
  head "svn://vcs.exim.org/pcre2/code/trunk"

  bottle do
    cellar :any
    sha256 "713086fd17e6d5543cc0144e3055ee0382dc1b092eb9fafdbda73a7b2539c363" => :sierra
    sha256 "151ff71a40f5b960c7504b77e0d5c18d8873a201c725c6b6d357f559a50722dd" => :el_capitan
    sha256 "18f0559c760d65f0f2323499fcf306c04576b3630a46d61a3582a37fb103bf29" => :yosemite
=======
  revision 1

  head "svn://vcs.exim.org/pcre2/code/trunk"

  stable do
    url "https://ftp.pcre.org/pub/pcre/pcre2-10.23.tar.bz2"
    mirror "https://www.mirrorservice.org/sites/ftp.exim.org/pub/pcre/pcre2-10.23.tar.bz2"
    sha256 "dfc79b918771f02d33968bd34a749ad7487fa1014aeb787fad29dd392b78c56e"

    # Fix for CVE-2017-8786.
    patch :p2 do
      url "https://vcs.pcre.org/pcre2/code/trunk/src/pcre2test.c?r1=692&r2=697&view=patch"
      sha256 "15041ad515e9daa513cb1b2c75c355000dc220864c1367fda3c1c47b9194ed43"
    end
  end

  bottle do
    cellar :any
    sha256 "bd1eb3a2de0b1d85639e615d338068a184b9c84f391fa350bf659dc989fc2a68" => :sierra
    sha256 "647a5f5c91b00532f8387e74fe84f1312050c1c45fe086a1658ed8c13db871f7" => :el_capitan
    sha256 "f1339759a9603b4e1f821c94e3687406fc7169fc55d943d0e97bfe643d07c236" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-pcre2-16",
                          "--enable-pcre2-32",
                          "--enable-pcre2grep-libz",
                          "--enable-pcre2grep-libbz2",
                          "--enable-jit"
    system "make"
    system "make", "check"
    system "make", "install"
  end

  test do
    system bin/"pcre2grep", "regular expression", prefix/"README"
  end
end
