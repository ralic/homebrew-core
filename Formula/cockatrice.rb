class Cockatrice < Formula
  desc "Virtual tabletop for multiplayer card games"
  homepage "https://github.com/Cockatrice/Cockatrice"
  url "https://github.com/Cockatrice/Cockatrice.git",
<<<<<<< HEAD
      :tag => "2017-04-15-Release-2.3.16",
      :revision => "dc6c3752201bd5a93f588a690cc462a118b3d40c"
  version "2.3.16"
=======
      :tag => "2017-05-05-Release-2.3.17",
      :revision => "c96f234b6d398cde949a1226fe17014dcc538c93"
  version "2.3.17"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  version_scheme 1
  head "https://github.com/Cockatrice/Cockatrice.git"

  bottle do
<<<<<<< HEAD
    sha256 "356615f5a2bbad45351cc4484743f8616335ffef95d01e2901ca47b09ff1a408" => :sierra
    sha256 "0f453dce61b0bc6fe442f431ac53b895ba4b47de26f50ab89e26f048ea28503c" => :el_capitan
    sha256 "9233b939255152d97a70fcad4e40292584e8a309d36a9ff676b705038756ce21" => :yosemite
  end

  option "with-server", "Build `servatrice` for running game servers"

  depends_on :macos => :mavericks
  depends_on "cmake" => :build
  depends_on "protobuf"

  if build.with? "server"
    depends_on "qt" => "with-mysql"
  else
    depends_on "qt"
  end
=======
    sha256 "c17637f762fa2ec3de8d1a2d335de3fa44b1cae79360df091c95cd28e20836c3" => :sierra
    sha256 "e656fab639c53bada209f91158540218d818c8311e8b097c0e610135efc3b0a1" => :el_capitan
    sha256 "dece3b5e2276e51e614be6c05f649cf972b4796c50cce08b3dda92b01495caa0" => :yosemite
  end

  depends_on :macos => :mavericks
  depends_on "cmake" => :build
  depends_on "protobuf"
  depends_on "qt"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.

  fails_with :clang do
    build 503
    cause "Undefined symbols for architecture x86_64: google::protobuf"
  end

  def install
    mkdir "build" do
<<<<<<< HEAD
      args = std_cmake_args
      args << "-DWITH_SERVER=ON" if build.with? "server"
      system "cmake", "..", *args
=======
      system "cmake", "..", *std_cmake_args
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
      system "make", "install"
      prefix.install Dir["release/*.app"]
    end
    doc.install Dir["doc/usermanual/*"]
  end

  test do
    (prefix/"cockatrice.app/Contents/MacOS/cockatrice").executable?
    (prefix/"oracle.app/Contents/MacOS/oracle").executable?
  end
end
