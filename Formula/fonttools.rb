class Fonttools < Formula
  include Language::Python::Virtualenv

  desc "Library for manipulating fonts"
  homepage "https://github.com/fonttools/fonttools"
<<<<<<< HEAD
  url "https://github.com/fonttools/fonttools/releases/download/3.10.0/fonttools-3.10.0.zip"
  sha256 "d165f83078a8f1bb9f466b12cee1ff402f39ebf143970762ef34abdb13fd4255"
=======
  url "https://github.com/fonttools/fonttools/releases/download/3.11.0/fonttools-3.11.0.zip"
  sha256 "b9f0c93914d83f27b32b5eb89c640ce1f1cb6f8466bff6079ff27903275f8994"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/fonttools/fonttools.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "257540f8a8a20c637bcc1a9b58ca4cc238e9a5e5bcdb6c90469e86eb0cecc822" => :sierra
    sha256 "5e67db3593196cc727899b0864d60fb54c3fa499486146230443c9b714788114" => :el_capitan
    sha256 "4c381f702c44753b8765cf88d09663084da40acc6d5c64bb723da6b2c26e699c" => :yosemite
=======
    sha256 "80f411cc801c5bd9eb628906d803c0104264da426cd7877fe49b15a54570d2a2" => :sierra
    sha256 "afeeb89590468e228105c677af855d1c6f290211d08a9b667fa243506dcace1a" => :el_capitan
    sha256 "cedf788f998df47cfd9b7a1e903576ac0a5d5557c98a4e71eb1710aaf8801eac" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  option "with-pygtk", "Build with pygtk support for pyftinspect"

  depends_on :python if MacOS.version <= :snow_leopard
  depends_on "pygtk" => :optional

  def install
    virtualenv_install_with_resources
  end

  test do
    cp "/Library/Fonts/Arial.ttf", testpath
    system bin/"ttx", "Arial.ttf"
  end
end
