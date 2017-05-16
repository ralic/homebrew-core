class Zstd < Formula
  desc "Zstandard is a real-time compression algorithm"
  homepage "http://zstd.net/"
<<<<<<< HEAD
  url "https://github.com/facebook/zstd/archive/v1.1.4.tar.gz"
  sha256 "6aae2b586e359344cb8ecfe6917a407dc7e01b5d7d7388559714de37900fb9fb"

  bottle do
    cellar :any
    sha256 "22b77f70740763574e611dadf154c8ca3ba9810544b9121857b69c4d3faec696" => :sierra
    sha256 "2d72e2f0f7a56200bf555a8b9c272b02ed66bf166a2e34040d03c7ecd82f7098" => :el_capitan
    sha256 "52a1193dfb3d93c71c92bd66fe974efef6252d1e4367a158a701c74ea79aafe9" => :yosemite
=======
  url "https://github.com/facebook/zstd/archive/v1.2.0.tar.gz"
  sha256 "4a7e4593a3638276ca7f2a09dc4f38e674d8317bbea51626393ca73fc047cbfb"

  bottle do
    cellar :any
    sha256 "bc2ff6cb7373b79d53896ded9b54fbaf225dc24621dee26dbe9d482ff592274a" => :sierra
    sha256 "70cd43a12ae9a638221725bb3ca770d8080ed437c3f9f34a8789e44642e40e65" => :el_capitan
    sha256 "2d0e998725164b7cee9197f5cf5d254370250528adfb1b0328b65683fd2a1ce5" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  option "without-pzstd", "Build without parallel (de-)compression tool"

  depends_on "cmake" => :build

  def install
    system "make", "install", "PREFIX=#{prefix}/"

    if build.with? "pzstd"
      system "make", "-C", "contrib/pzstd", "googletest"
      system "make", "-C", "contrib/pzstd", "PREFIX=#{prefix}"
      bin.install "contrib/pzstd/pzstd"
    end
  end

  test do
    assert_equal "hello\n",
      pipe_output("#{bin}/zstd | #{bin}/zstd -d", "hello\n", 0)

    if build.with? "pzstd"
      assert_equal "hello\n",
        pipe_output("#{bin}/pzstd | #{bin}/pzstd -d", "hello\n", 0)
    end
  end
end
