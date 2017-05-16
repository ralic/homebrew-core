class Folly < Formula
  desc "Collection of reusable C++ library artifacts developed at Facebook"
  homepage "https://github.com/facebook/folly"
<<<<<<< HEAD
  url "https://github.com/facebook/folly/archive/v2017.05.01.00.tar.gz"
  sha256 "cbcff2ded96dd8d8b6361c4553ed881a559342a219f90fa1eed8702972d44bb5"
=======
  url "https://github.com/facebook/folly/archive/v2017.05.08.00.tar.gz"
  sha256 "62f7c8032eb52dbe6733261f7bfde92336325076731de78825dc08d7d3cf1368"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/facebook/folly.git"

  bottle do
    cellar :any
<<<<<<< HEAD
    sha256 "24b727be12d2de16e45266e4170ff8643e9cc71908519f0b8d6dca9ca459b3f6" => :sierra
    sha256 "a9470a5b2cf882ec30ed05d7ca56b94452f10aa0325cf2f789d23cb24fb91b92" => :el_capitan
=======
    sha256 "0886ba3bcb9a2c7498410b6ca3b6d044653b3d002616f8524bf3620aaa677be2" => :sierra
    sha256 "44f518c366bfba8b8ed13a9ae7031a51f9ec14c30a3718c3a027d0acd578f39c" => :el_capitan
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "double-conversion"
  depends_on "glog"
  depends_on "gflags"
  depends_on "boost"
  depends_on "libevent"
  depends_on "xz"
  depends_on "snappy"
  depends_on "lz4"
  depends_on "openssl"

  # https://github.com/facebook/folly/issues/451
  depends_on :macos => :el_capitan

  needs :cxx11

  # Known issue upstream. They're working on it:
  # https://github.com/facebook/folly/pull/445
  fails_with :gcc => "6"

  def install
    ENV.cxx11

    cd "folly" do
      system "autoreconf", "-fvi"
      system "./configure", "--prefix=#{prefix}", "--disable-silent-rules",
                            "--disable-dependency-tracking"
      system "make"
      system "make", "install"
    end
  end

  test do
    (testpath/"test.cc").write <<-EOS.undent
      #include <folly/FBVector.h>
      int main() {
        folly::fbvector<int> numbers({0, 1, 2, 3});
        numbers.reserve(10);
        for (int i = 4; i < 10; i++) {
          numbers.push_back(i * 2);
        }
        assert(numbers[6] == 12);
        return 0;
      }
    EOS
    system ENV.cxx, "-std=c++11", "test.cc", "-I#{include}", "-L#{lib}",
                    "-lfolly", "-o", "test"
    system "./test"
  end
end
