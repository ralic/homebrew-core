class Neatvi < Formula
  desc "ex/vi clone for editing bidirectional uft-8 text"
  homepage "http://repo.or.cz/w/neatvi.git"
  url "git://repo.or.cz/neatvi.git",
<<<<<<< HEAD
    :tag => "04", :revision => "3bf27b04ec791df5a624dc4487422f382b96327c"
=======
    :tag => "05", :revision => "ed2e096607df03ce155e4c6ab786f8b697799988"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.

  head "git://repo.or.cz/neatvi.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "a085add28099e0a112efab55d61d3c339419129848181cf0ca2bf3e278807e0a" => :sierra
    sha256 "39a2a3b6e82806ea132ae6a3242147feb497c31c04ce68f62e93c4d808ca0d22" => :el_capitan
    sha256 "904e045bf6bd1dea374e9091882cdf25a80fe786bbee9cfa42d0221228ec01d8" => :yosemite
=======
    sha256 "4af6bb9a7d0b654f929665393e97e250b34eb6b678d107d36143f524f7dea173" => :sierra
    sha256 "0dcdf4372cf9a0c3d837df0471511838539c6250351c93711a981444ab1bb11d" => :el_capitan
    sha256 "c715f3a039031f83bd71eb6ce21caedba923ad3d78692df24ccfd9ed80b1b099" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  def install
    system "make"
    bin.install "vi" => "neatvi"
  end

  test do
    pipe_output("#{bin}/neatvi", ":q\n")
  end
end
