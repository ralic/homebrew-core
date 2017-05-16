class Mupdf < Formula
  desc "Lightweight PDF and XPS viewer"
<<<<<<< HEAD
  homepage "https://mupdf.com"
  url "https://mupdf.com/downloads/mupdf-1.10a-source.tar.gz"
  sha256 "aacc1f36b9180f562022ef1ab3439b009369d944364f3cff8a2a898834e3a836"

  bottle do
    cellar :any_skip_relocation
    sha256 "c6ba5009c3d93bef7271abf1237966ef37668ca7c4efa9acbb08c2b34ecc13b7" => :sierra
    sha256 "c1730640c3797ffad7c67637a640ca97d882ff71f7a625bcf0b6bdea38f04374" => :el_capitan
    sha256 "37886d6e77a7842c2c05e29bcc8d4035f555ca7a2538121399d607a52d5d2cc2" => :yosemite
  end

  depends_on :macos => :snow_leopard
=======
  homepage "https://mupdf.com/"
  url "https://mupdf.com/downloads/mupdf-1.11-source.tar.gz"
  sha256 "209474a80c56a035ce3f4958a63373a96fad75c927c7b1acdc553fc85855f00a"
  head "https://git.ghostscript.com/mupdf.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "db79eda74b6e0aee69a92859a72a9cbb9a4497ff7fbdb73bce2af1984b93b1a3" => :sierra
    sha256 "a05de229404807b12a302da6d85141701d6b31e528ae4dbb612ad53d65b73221" => :el_capitan
    sha256 "4a6fda775162b101b4fe907bda57277fcb19514aaa4ae434ef6ad155ee72e649" => :yosemite
  end

>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  depends_on :x11
  depends_on "openssl"

  conflicts_with "mupdf-tools",
    :because => "mupdf and mupdf-tools install the same binaries."

  def install
<<<<<<< HEAD
=======
    # Work around bug: https://bugs.ghostscript.com/show_bug.cgi?id=697842
    inreplace "Makerules", "RANLIB_CMD := xcrun", "RANLIB_CMD = xcrun"

>>>>>>> kettle: fix hardcoded /usr/local idiocy.
    system "make", "install",
           "build=release",
           "verbose=yes",
           "CC=#{ENV.cc}",
<<<<<<< HEAD
           "prefix=#{prefix}"
=======
           "prefix=#{prefix}",
           "HAVE_GLFW=no" # Do not build OpenGL viewer: https://bugs.ghostscript.com/show_bug.cgi?id=697842
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
    bin.install_symlink "mutool" => "mudraw"
  end

  test do
<<<<<<< HEAD
    pdf = test_fixtures("test.pdf")
    assert_match /Homebrew test/, shell_output("#{bin}/mudraw -F txt #{pdf}")
=======
    assert_match "Homebrew test", shell_output("#{bin}/mudraw -F txt #{test_fixtures("test.pdf")}")
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end
end
