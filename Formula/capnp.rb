class Capnp < Formula
  desc "Data interchange format and capability-based RPC system"
  homepage "https://capnproto.org/"
<<<<<<< HEAD
  url "https://capnproto.org/capnproto-c++-0.5.3.1.tar.gz"
  sha256 "04b5c56805895fd15751167ab04c99fa86602110ea7591ef611695de9923911b"

  bottle do
    cellar :any_skip_relocation
    sha256 "1c017adc3ee4e0f1af501a3228d1069995750561ac0459c3430aa90c178a77fc" => :sierra
    sha256 "821b56780106b139788ecdcad979dd8f5af734e6aae776ffc6476943ab6ab542" => :el_capitan
    sha256 "35edb1dacc06cf7c784b37b8625f0cea35a190ecb6fe6e5d913b40eb34c3fa5f" => :yosemite
=======
  url "https://capnproto.org/capnproto-c++-0.6.0.tar.gz"
  sha256 "e50911191afc44d6ab03b8e0452cf8c00fd0edfcd34b39f169cea6a53b0bf73e"

  bottle do
    cellar :any_skip_relocation
    sha256 "fe035ee20666f60bea72a033625e30981da7cf49bca28e3ded78daeb9a0cc9f3" => :sierra
    sha256 "5ef99277556769e117350e4c4c625c4498aab44aec043c24a3e8596ee98a311a" => :el_capitan
    sha256 "7068ca3b3c0db13d8669d1c6e70c5a4a5f31872b70741c8cd54485b5f66052db" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  needs :cxx11
  depends_on "cmake" => :build

<<<<<<< HEAD
  resource "gtest" do
    url "https://github.com/google/googletest/archive/release-1.7.0.tar.gz"
    sha256 "f73a6546fdf9fce9ff93a5015e0333a8af3062a152a9ad6bcb772c96687016cc"
  end

  def install
    ENV.cxx11

    gtest = resource("gtest")
    gtest.verify_download_integrity(gtest.fetch)
    inreplace "src/CMakeLists.txt" do |s|
      s.gsub! "https://github.com/google/googletest/archive/release-1.7.0.zip",
              gtest.cached_download
      s.gsub! "URL_MD5 ef5e700c8a0f3ee123e2e0209b8b4961",
              "URL_HASH SHA256=#{gtest.checksum}"
    end

=======
  def install
    ENV.cxx11
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    file = testpath/"test.capnp"
    text = "\"Is a happy little duck\""

    file.write Utils.popen_read("#{bin}/capnp id").chomp + ";\n"
    file.append_lines "const dave :Text = #{text};"
    assert_match text, shell_output("#{bin}/capnp eval #{file} dave")
  end
end
