class AwsSdkCpp < Formula
  desc "AWS SDK for C++"
  homepage "https://github.com/aws/aws-sdk-cpp"
<<<<<<< HEAD
  url "https://github.com/aws/aws-sdk-cpp/archive/1.0.112.tar.gz"
  sha256 "2717b765434a453b7926c6fe89bb06f44386b095ddcc2a6db8cc11521ab78690"
=======
  url "https://github.com/aws/aws-sdk-cpp/archive/1.0.118.tar.gz"
  sha256 "038e2a8cf2e62fd6a03c13afa56170766ccb69392a6eb06334a876a4a7190d2b"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/aws/aws-sdk-cpp.git"

  bottle do
    cellar :any
<<<<<<< HEAD
    sha256 "88a544348b4658e4c38b208895b312cd54a312987616a7b6a9a8f71380873feb" => :sierra
    sha256 "1e58aae8a3a518e46170f542645dccf3548bb08d6fab49446eb42480720fc2aa" => :el_capitan
    sha256 "f15321dff6966490ef5d7956538ffc070d0b8cb913cf16101fc0f3b52a4e5fa3" => :yosemite
=======
    sha256 "444e794e809f8d81dcd0caae0f2cdce26a7a037511ead0960dbc5c59c3077029" => :sierra
    sha256 "dddc0be7604addf2d19e60716919559f451ac29c4c85f18f17feea96afb73dd1" => :el_capitan
    sha256 "51f04c1124aee192f33186bfc7be6b87c3e009ba1f31f9d3584f1a044e673cb3" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  option "with-static", "Build with static linking"
  option "without-http-client", "Don't include the libcurl HTTP client"

  depends_on "cmake" => :build

  def install
    args = std_cmake_args
    args << "-DSTATIC_LINKING=1" if build.with? "static"
    args << "-DNO_HTTP_CLIENT=1" if build.without? "http-client"

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      system "make", "install"
    end

    lib.install Dir[lib/"mac/Release/*"].select { |f| File.file? f }
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include <aws/core/Version.h>
      #include <iostream>

      int main() {
          std::cout << Aws::Version::GetVersionString() << std::endl;
          return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-o", "test", "-laws-cpp-sdk-core"
    system "./test"
  end
end
