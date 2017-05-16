class AmqpCpp < Formula
  desc "C++ library for communicating with a RabbitMQ message broker"
  homepage "https://github.com/CopernicaMarketingSoftware/AMQP-CPP"
<<<<<<< HEAD
  url "https://github.com/CopernicaMarketingSoftware/AMQP-CPP/archive/v2.7.0.tar.gz"
  sha256 "4668a5dab5bc0b1dda2bb1253e7c3214f6fce9f3edcf8728fad01bb6c8a29b97"
=======
  url "https://github.com/CopernicaMarketingSoftware/AMQP-CPP/archive/v2.7.3.tar.gz"
  sha256 "b1e5c6124056d67aefc4bb8b0a93cce3d0a9f6b897c47da9475bd40247fa33f9"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/CopernicaMarketingSoftware/AMQP-CPP.git"

  bottle do
    cellar :any
<<<<<<< HEAD
    sha256 "ba97c25a734c8a2d0fe3dbfcdedb5d1a0e8e017fcf39367d0512384bd9452839" => :sierra
    sha256 "d6d1bec354a54699871c93a65dff4d8ed92ba444cea4cf288f414bc87008cf48" => :el_capitan
    sha256 "75650d6a44f1ce9069d9a36bd5f4e69ea539973e2608157a3841b38c16ee978b" => :yosemite
=======
    sha256 "385de73989606bb2fed2bac8378b7c13b6329270698d8d5b3173fe2c8a4cd9e3" => :sierra
    sha256 "b497747f2cee526765574f30c413dc3cfd97d8d0a8f07ef38a44b4f12ff54fae" => :el_capitan
    sha256 "5c405ed3753c18d155a8f3a0def332d8229178155376d1fb5bac94085ed9e34a" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  needs :cxx11

  depends_on "cmake" => :build

  def install
    ENV.cxx11

<<<<<<< HEAD
    # Workarounds for https://github.com/CopernicaMarketingSoftware/AMQP-CPP/issues/123
    cp Dir["include/{endian,exception,frame,protocolexception}.h"], "src/"
    inreplace "src/CMakeLists.txt", /^messageimpl.h$\n/, ""

=======
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
    system "cmake", "-DBUILD_SHARED=ON", "-DCMAKE_MACOSX_RPATH=1", *std_cmake_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include <amqpcpp.h>
      int main()
      {
        return 0;
      }
      EOS
    system ENV.cxx, "test.cpp", "-std=c++11", "-L#{lib}", "-o",
                    "test", "-lc++", "-lamqp-cpp"
    system "./test"
  end
end
