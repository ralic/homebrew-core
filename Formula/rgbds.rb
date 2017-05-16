class Rgbds < Formula
  desc "Rednex GameBoy Development System"
  homepage "https://github.com/rednex/rgbds"
<<<<<<< HEAD
  url "https://github.com/rednex/rgbds/archive/v0.3.0.tar.gz"
  sha256 "00a8ac8cfaeaf5285fd24475a3d78053a35fd9599ab9493ca47dc41bcb6f7de0"
=======
  url "https://github.com/rednex/rgbds/archive/v0.3.1.tar.gz"
  sha256 "3f58bc39fe9e90168d7618093160ce3caf9bdd3cfda311e92f618eb7ccba6f2d"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/rednex/rgbds.git"

  bottle do
    cellar :any
<<<<<<< HEAD
    sha256 "a3bedd40aa36d2d1117d8fcd9c101161db73f125e70ef6fae4026fda049206c8" => :sierra
    sha256 "04e22d56594f10b991388ddcad4882ab3f62da8519f7806f32d988c050f2c27c" => :el_capitan
    sha256 "cebded8ba6cfa5470ce26c6eec742772e48eb3812f69484afa4591321d60225f" => :yosemite
=======
    sha256 "92eaf4a84c12a39bacb64f4e01ccf431798822a432a8215f69ebbaab924823fc" => :sierra
    sha256 "b5afb551e61a709eb6333276e0d5b16dced5ec7e08c138e5f702582caa03347b" => :el_capitan
    sha256 "38f4d8ce78bf285e753f7bfc43cf222ecc40471f34bb7672b4ac35be9f85e0a7" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "pkg-config" => :build
  depends_on "libpng"

  def install
    system "make", "install", "PREFIX=#{prefix}", "mandir=#{man}"
  end

  test do
    (testpath/"source.asm").write <<-EOS.undent
      SECTION "Org $100",HOME[$100]
      nop
      jp begin
      begin:
        ld sp, $ffff
        ld a, $1
        ld b, a
        add a, b
    EOS
    system "#{bin}/rgbasm", "source.asm"
  end
end
