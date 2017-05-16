class MupdfTools < Formula
  desc "Lightweight PDF and XPS viewer"
  homepage "https://mupdf.com/"
<<<<<<< HEAD
  url "https://mupdf.com/downloads/archive/mupdf-1.10a-source.tar.gz"
  sha256 "aacc1f36b9180f562022ef1ab3439b009369d944364f3cff8a2a898834e3a836"
=======
  url "https://mupdf.com/downloads/mupdf-1.11-source.tar.gz"
  sha256 "209474a80c56a035ce3f4958a63373a96fad75c927c7b1acdc553fc85855f00a"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://git.ghostscript.com/mupdf.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "78c316d6d9abf1c780020ea47400e194c088fe5d169bc24900a57df73df2338a" => :sierra
    sha256 "35827daa262f98d2f8678e8c75efebb90aed82c671a0355e70654b086c98ed5a" => :el_capitan
    sha256 "99172765ae5dc646bae6bd67e6dabd5e7203b30d8d75b68022d3db10a2dc929e" => :yosemite
  end

  depends_on :macos => :snow_leopard

  def install
=======
    sha256 "b758f982d165d1a78caf8ce612de4103f0fa5312d1ef5ea78003beece2698504" => :sierra
    sha256 "b3058793714bb01bf5281bd1a64b914dffc1bcbe3938665ec59f41036828fb7b" => :el_capitan
    sha256 "1984e3b0e8e71d4b1add14be7d1f4b9625b1a0dbe67c64fd67f0db237d5e78c5" => :yosemite
  end

  def install
    # Work around bug: https://bugs.ghostscript.com/show_bug.cgi?id=697842
    inreplace "Makerules", "RANLIB_CMD := xcrun", "RANLIB_CMD = xcrun"

>>>>>>> kettle: fix hardcoded /usr/local idiocy.
    system "make", "install",
           "build=release",
           "verbose=yes",
           "HAVE_X11=no",
           "CC=#{ENV.cc}",
<<<<<<< HEAD
           "prefix=#{prefix}"
=======
           "prefix=#{prefix}",
           "HAVE_GLFW=no" # Do not build OpenGL viewer: https://bugs.ghostscript.com/show_bug.cgi?id=697842
>>>>>>> kettle: fix hardcoded /usr/local idiocy.

    # Symlink `mutool` as `mudraw` (a popular shortcut for `mutool draw`).
    bin.install_symlink bin/"mutool" => "mudraw"
    man1.install_symlink man1/"mutool.1" => "mudraw.1"
  end

  test do
<<<<<<< HEAD
    pdf = test_fixtures("test.pdf")
    assert_match "Homebrew test", shell_output("#{bin}/mutool draw -F txt #{pdf}")
=======
    assert_match "Homebrew test", shell_output("#{bin}/mutool draw -F txt #{test_fixtures("test.pdf")}")
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end
end
