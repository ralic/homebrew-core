class Xmake < Formula
  desc "Make-like build utility based on Lua"
  homepage "http://xmake.io"
<<<<<<< HEAD
  url "https://github.com/waruqi/xmake/archive/v2.1.3.tar.gz"
  sha256 "e84031bed87c052944d0e590aba44087cee836eec0ef797363c4172361a81f6b"
=======
  url "https://github.com/tboox/xmake/archive/v2.1.4.tar.gz"
  sha256 "75be6abea3939b6ce9b306fca2a842a0bdd02ee1c5ad04b43445e2b36daa4837"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/waruqi/xmake.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "fbafa253cf76a3e91495289676bd58ea6a34a83e9822a0bb2a8f754df605837c" => :sierra
    sha256 "46bafc5940a7e5822a0771d95060eb0ee2dbeb0937b707103bc182623a917305" => :el_capitan
    sha256 "de17adb4711c6eb76b200639d6089cc280055a199b75d18b46e91ba78f03ba77" => :yosemite
=======
    sha256 "916ebbf59ecaece1bc27462fd31ec1633005de201adb70d986e9308de0a40013" => :sierra
    sha256 "79f78a202c29fa947d75c277a130130375fb853d345224fb798d0731fe6d2418" => :el_capitan
    sha256 "c9d5e18377434432f957eeaae6a5a14e8fce527ba14a1b6ffc798f21cfda511e" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  def install
    system "./install", "output"
    pkgshare.install Dir["xmake/*"]
    bin.install "output/share/xmake/xmake"
    bin.env_script_all_files(libexec, :XMAKE_PROGRAM_DIR => pkgshare)
  end

  test do
    system bin/"xmake", "create", "-P", testpath
    assert_match "build ok!", pipe_output(bin/"xmake")
  end
end
