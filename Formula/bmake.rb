class Bmake < Formula
  desc "Portable version of NetBSD make(1)"
  homepage "http://www.crufty.net/help/sjg/bmake.html"
<<<<<<< HEAD
  url "http://www.crufty.net/ftp/pub/sjg/bmake-20170421.tar.gz"
  sha256 "763104954b566ae9f575ea682dc38ed5c73057336f5f6090fb7489a5399511c5"

  bottle do
    sha256 "2864c47399ecaa548879cd928ace12c15d4dc7a73a3bac0f89a3d6c56f78dee4" => :sierra
    sha256 "d9c73c9f1891fe15b1eed51e5df8ff0f49339e4d691300a844152293db00af49" => :el_capitan
    sha256 "ccb121af0dc6ddaa15f277d7d56cab2aebe8cd1a3048b1e670233868d772325a" => :yosemite
=======
  url "http://www.crufty.net/ftp/pub/sjg/bmake-20170510.tar.gz"
  sha256 "ce5d73a8b5267495132bd00392a411178155dafecd66b50860419e9cf8683e3c"

  bottle do
    sha256 "3868471c0c312301d63f67d7580da16008a1ce5df3ee184eeba149dc9d4a3419" => :sierra
    sha256 "51fe93b1b3e62af08ed45b5d5a22bcc03bbb0d1fd0e87addc0662ebc2466d8b7" => :el_capitan
    sha256 "ebc184e50bb311c51f40af0b0358cbe910ab81933be3e2eaa9b11ca43e586450" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  def install
    # Don't pre-roff cat pages.
    inreplace "mk/man.mk", "MANTARGET?", "MANTARGET"

    # -DWITHOUT_PROG_LINK means "don't symlink as bmake-VERSION."
    args = ["--prefix=#{prefix}", "-DWITHOUT_PROG_LINK", "--install"]
    system "sh", "boot-strap", *args

    man1.install "bmake.1"
  end

  test do
    (testpath/"Makefile").write <<-EOS.undent
      all: hello

      hello:
      \t@echo 'Test successful.'

      clean:
      \trm -rf Makefile
    EOS
    system bin/"bmake"
    system bin/"bmake", "clean"
  end
end
