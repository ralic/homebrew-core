class FluentBit < Formula
  desc "Data Collector for IoT"
  homepage "https://github.com/fluent/fluent-bit"
<<<<<<< HEAD
  url "https://github.com/fluent/fluent-bit/archive/v0.11.4.tar.gz"
  sha256 "d3d3b53f0877e3d9df39cdfbac7eb78519df11cb1e8adc6bd78eb535895dd57a"
=======
  url "https://github.com/fluent/fluent-bit/archive/v0.11.5.tar.gz"
  sha256 "947849f933500c8847a3d7671a98be1a9e43159717c6da79120e31c2da0f0e6d"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/fluent/fluent-bit.git"

  bottle do
    cellar :any
<<<<<<< HEAD
    sha256 "0c42e08b4a61196adae4d170539ae03f9aacf2405e5661d9db783e61b9dae3ec" => :sierra
    sha256 "c2bdc8415f554a85891eb2f3241b33e4b1cb3f382eb9a14c62a0c6e83b269433" => :el_capitan
    sha256 "6e0a5362abdfdf9985eca928abd5db456cb8cdc229e7c5e5c366b89a97266198" => :yosemite
=======
    sha256 "7614b4df64cf2902a2efeb2f206665da3f2ffd274f0be1ebef4e66747d978c01" => :sierra
    sha256 "847f45e36e7e23ebf63976ace96721b2fa61a15532b0f7d713f6a6f74b55e98c" => :el_capitan
    sha256 "fe2d850a5699444e69297c72d13bb26e5139e37b51e37a4cc6a2d4bd81c5c0e6" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "cmake" => :build

  conflicts_with "mbedtls", :because => "fluent-bit includes mbedtls libraries."
  conflicts_with "msgpack", :because => "fluent-bit includes msgpack libraries."

  def install
    system "cmake", ".", "-DWITH_IN_MEM=OFF", *std_cmake_args
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/fluent-bit -V").chomp
    assert_equal "Fluent Bit v#{version}", output
  end
end
