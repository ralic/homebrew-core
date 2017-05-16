class LibusbCompat < Formula
  desc "Library for USB device access"
<<<<<<< HEAD
  homepage "http://www.libusb.org/"
  url "https://downloads.sourceforge.net/project/libusb/libusb-compat-0.1/libusb-compat-0.1.5/libusb-compat-0.1.5.tar.bz2"
  sha256 "404ef4b6b324be79ac1bfb3d839eac860fbc929e6acb1ef88793a6ea328bc55a"

  bottle do
    cellar :any
    rebuild 1
    sha256 "fc626b53c9f667785f87536a62199cf59f8c59aa67a565ad99ab23805a85bd9a" => :sierra
    sha256 "df7e556f8af9bccb149bb26becc8a2e6cd9a3d22fc04b2ebf81e981abc892fef" => :el_capitan
    sha256 "564b4c326a98e27c164544531535be57668ce242ca536a7b34e3716b20f8cd00" => :yosemite
    sha256 "264bc9dacd754bae665907cd087e06e7063d15fbad38b336c567f76e7f886193" => :mavericks
    sha256 "239e6f2a527713c38b4e802cd25b80fbb01af30a88a36b77b591f5e95890511f" => :mountain_lion
=======
  homepage "http://libusb.info"
  url "https://downloads.sourceforge.net/project/libusb/libusb-compat-0.1/libusb-compat-0.1.5/libusb-compat-0.1.5.tar.bz2"
  sha256 "404ef4b6b324be79ac1bfb3d839eac860fbc929e6acb1ef88793a6ea328bc55a"
  revision 1

  bottle do
    cellar :any
    sha256 "e24ad80ee860f6f6c7e6c8dbb100aaa2de3294e2ecf7f591f2f51c52e11f09ea" => :sierra
    sha256 "7b62449f8a9c02834b74adeb0827ca2ae32b47cb82923de0a8e88f16c36ca8b8" => :el_capitan
    sha256 "0e4f131b8fd8210db3ff353a92c35ed12643a717b8780618680e3b4a16d7f347" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "pkg-config" => :build
  depends_on "libusb"

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make", "install"
  end

  test do
    system "#{bin}/libusb-config", "--libs"
  end
end
