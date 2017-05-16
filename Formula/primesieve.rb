class Primesieve < Formula
  desc "Fast C/C++ prime number generator"
  homepage "http://primesieve.org/"
<<<<<<< HEAD
  url "https://dl.bintray.com/kimwalisch/primesieve/primesieve-5.7.0.tar.gz"
  sha256 "4a3e542dd3079dd9c0caf2d67fbb7b79757f65d705bdc8cf50555e65653fa1d1"

  bottle do
    cellar :any
    sha256 "5e50eb398e186c61cf06d17d4c4cc3a42f5424ed40400f4392e9bcd890ae5951" => :sierra
    sha256 "bbf14a1041b404069102a0eb853fdfe8d099ccb3aa67a9b453e42f560919c4d9" => :el_capitan
    sha256 "159886a4250641220e2ef2c41f58caf3c595485df32340f68e9007214a860e6a" => :yosemite
    sha256 "b15504dd7f1bfb4cd9dc5d4474b7180bd5b345d49e10619f5383516efa061964" => :mavericks
  end

  def install
    system "./configure", "--disable-dependency-tracking", "--disable-silent-rules",
           "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/primesieve", "2", "1000", "--count=1", "-p2"
=======
  url "https://github.com/kimwalisch/primesieve/archive/v6.0.tar.gz"
  sha256 "4b462d9682c595fc4d332c9b22240c571a4c0d8331bcb38c854a50d36229678a"

  bottle do
    cellar :any
    sha256 "b350269dc60c22526ddb61086a252b982f9a519c0abde778a09933f37e514d8b" => :sierra
    sha256 "0cc700d26f7995d137c8b965e0173718a480960da462281ae09362ec98e12295" => :el_capitan
    sha256 "21b1dcd3d12577511352e47b6e724fb67b0e8296f151a6b6577b947c7c3e0fa4" => :yosemite
  end

  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    system "#{bin}/primesieve", "100", "--count", "--print"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end
end
