class Graphite2 < Formula
  desc "Smart font renderer for non-Roman scripts"
  homepage "http://graphite.sil.org"
<<<<<<< HEAD
  revision 1

  head "https://github.com/silnrsi/graphite.git"

  stable do
    url "https://github.com/silnrsi/graphite/releases/download/1.3.9/graphite2-1.3.9.tgz"
    # Debian mirror the release tarball, not the GitHub archive tarball.
    mirror "https://mirrors.ocf.berkeley.edu/debian/pool/main/g/graphite2/graphite2_1.3.9.orig.tar.gz"
    sha256 "ec0185b663059553fd46e8c4a4f0dede60a02f13a7a1fefc2ce70332ea814567"

    # Patch for CVE-2017-5436.
    # https://www.vuxml.org/freebsd/cf133acc-82e7-4755-a66a-5ddf90dacbe6.html
    patch do
      url "https://github.com/silnrsi/graphite/commit/1ce331d5548b.patch"
      sha256 "39613db98f959b48adc2387d37a5f384566172b906d949edad452fcd48c3874c"
    end
  end

  bottle do
    cellar :any
    sha256 "dfca853f8ad5b826227e2f5d6dbb0de177e4e4226d255b856c3501fda09dbf3d" => :sierra
    sha256 "271745aed3d0fdf8ded9037df02a404fa883060e7bc46c7c2b9d6f8cbb1022b4" => :el_capitan
    sha256 "325c033b1fd5934ef36735ec2b5ca4c33dd832e80ac09d1164b429e86d71114f" => :yosemite
=======
  url "https://github.com/silnrsi/graphite/releases/download/1.3.10/graphite2-1.3.10.tgz"
  sha256 "90fde3b2f9ea95d68ffb19278d07d9b8a7efa5ba0e413bebcea802ce05cda1ae"
  head "https://github.com/silnrsi/graphite.git"

  bottle do
    cellar :any
    sha256 "8275f72e0fc1aaa42b30b46d2245565571e97d56ebbad3fa94994d235f935eea" => :sierra
    sha256 "3bdeb624f9cc9e71ad554cfa243ff64eac4b3f948a34ed8e1a6d7f9b168b996d" => :el_capitan
    sha256 "e26eb396511e1a327a8173653e65960b14a4499738ef5eb7c54c8d8474fdc011" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "cmake" => :build

  resource "testfont" do
    url "https://scripts.sil.org/pub/woff/fonts/Simple-Graphite-Font.ttf"
    sha256 "7e573896bbb40088b3a8490f83d6828fb0fd0920ac4ccdfdd7edb804e852186a"
  end

  def install
    system "cmake", *std_cmake_args
    system "make", "install"
  end

  test do
    resource("testfont").stage do
      shape = shell_output("#{bin}/gr2fonttest Simple-Graphite-Font.ttf 'abcde'")
      assert_match /67.*36.*37.*38.*71/m, shape
    end
  end
end
