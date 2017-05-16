class Openrct2 < Formula
  desc "Open source re-implementation of RollerCoaster Tycoon 2"
  homepage "https://openrct2.website"
<<<<<<< HEAD
  url "https://github.com/OpenRCT2/OpenRCT2/archive/v0.0.6.tar.gz"
  sha256 "c4e04359ef91bedf58fbd9da57c39ba59066840a467aa0346c4a6353b0ae33f5"
=======
  url "https://github.com/OpenRCT2/OpenRCT2/archive/v0.0.7.tar.gz"
  sha256 "cf35b6e058d675ae8369c9845f9c7c9e4269a1f4a57da91dcdcdcde7e608adac"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/OpenRCT2/OpenRCT2.git", :branch => "develop"

  bottle do
    cellar :any
<<<<<<< HEAD
    sha256 "032c1b75b68b5651e6aea5a49ae18c37a1d63ffda4a850333a551acd1fd69587" => :sierra
    sha256 "b06b28693bfca1419517e0ba08ff33823dd07fbbc5578c07b359328793120882" => :el_capitan
    sha256 "bc4e64492d425929e3062d88a69392138d9717423f75aae29f17c0252a8dbb0f" => :yosemite
=======
    sha256 "63499f130b12f8ee7698d0822c2437ade72dc23a92c87b1c87f4d4dcd8568127" => :sierra
    sha256 "cd7102e02ea38266a85a52aba741d1682198423ac77ab24cf186ee0e41b099aa" => :el_capitan
    sha256 "daec48d326834a85450afaf275b5f1fce5f49bb4aec1543f5bd8287f761f68c8" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "jansson"
  depends_on "libpng"
  depends_on "libzip"
  depends_on "openssl"
  depends_on "sdl2"
  depends_on "sdl2_ttf"
  depends_on "speexdsp"
  depends_on "freetype" # for sdl2_ttf

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end

    # By default OS X build only looks up data in app bundle Resources
    libexec.install bin/"openrct2"
    (bin/"openrct2").write <<-EOS.undent
      #!/bin/bash
      exec "#{libexec}/openrct2" "$@" "--openrct-data-path=#{pkgshare}"
      EOS
  end

  test do
    assert_match /OpenRCT2, v#{version}/, shell_output("#{bin}/openrct2 -v")
  end
end
