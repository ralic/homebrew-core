<<<<<<< HEAD
# This formula tracks GnuPG stable. You can find GnuPG Modern via:
# brew install homebrew/versions/gnupg21
# At the moment GnuPG Modern causes too many incompatibilities to be in core.
=======
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
class GpgAgent < Formula
  desc "GPG key agent"
  homepage "https://www.gnupg.org/"
  url "https://gnupg.org/ftp/gcrypt/gnupg/gnupg-2.0.30.tar.bz2"
  mirror "https://www.mirrorservice.org/sites/ftp.gnupg.org/gcrypt/gnupg/gnupg-2.0.30.tar.bz2"
  sha256 "e329785a4f366ba5d72c2c678a7e388b0892ac8440c2f4e6810042123c235d71"
<<<<<<< HEAD
  revision 2

  bottle do
    sha256 "3b8ac273dd1592d0c10b4a114c58994988b1bdb2a2555698a7f28f169a245991" => :sierra
    sha256 "3d1cf4b576165b5c7467df199332a88a1de0e4e009616567c72a3867906e43e4" => :el_capitan
    sha256 "82508864a623ccbdbaded03dc50d487e3744742f3205040f5087289b5761c324" => :yosemite
  end

  keg_only "GPG 2.1.x ships an internal gpg-agent which it must use."
=======
  revision 3

  bottle do
    sha256 "a59b4f9f60137448d591e1c702dd5e1548e424058af87a4da318a7ef8cffb23f" => :sierra
    sha256 "edf496c4ea0cce7b46a1ef1d39f6b0feae02b8479f2772bc3dc448a4d5f7cdc8" => :el_capitan
    sha256 "b5cb2ff4333b5e7416d876daedc1170a98217c12789a4dae48c9794457822059" => :yosemite
  end

  keg_only "GPG 2.1.x ships an internal gpg-agent which it must use"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.

  depends_on "libgpg-error"
  depends_on "libgcrypt"
  depends_on "libksba"
  depends_on "libassuan"
  depends_on "pth"
  depends_on "pinentry"

  def install
    # don't use Clang's internal stdint.h
    ENV["gl_cv_absolute_stdint_h"] = "#{MacOS.sdk_path}/usr/include/stdint.h"

    # Adjust package name to fit our scheme of packaging both
    # gnupg 1.x and 2.x, and gpg-agent separately
    inreplace "configure" do |s|
      s.gsub! "PACKAGE_NAME='gnupg'", "PACKAGE_NAME='gpg-agent'"
      s.gsub! "PACKAGE_TARNAME='gnupg'", "PACKAGE_TARNAME='gpg-agent'"
    end

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-agent-only",
                          "--with-pinentry-pgm=#{Formula["pinentry"].opt_bin}/pinentry",
<<<<<<< HEAD
                          "--with-scdaemon-pgm=#{Formula["gnupg2"].opt_libexec}/scdaemon"
=======
                          "--with-scdaemon-pgm=#{Formula["gnupg@2.0"].opt_libexec}/scdaemon"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
    system "make", "install"
  end

  def caveats; <<-EOS.undent
      Remember to add "use-standard-socket" to your ~/.gnupg/gpg-agent.conf
      file.
    EOS
  end

  test do
    system "#{bin}/gpg-agent", "--help"
  end
end
