class Mediaconch < Formula
  desc "Conformance checker and technical metadata reporter"
  homepage "https://mediaarea.net/MediaConch"
<<<<<<< HEAD
  url "https://mediaarea.net/download/binary/mediaconch/17.03/MediaConch_CLI_17.03_GNU_FromSource.tar.bz2"
  version "17.03"
  sha256 "1dc6521e8ac51d4da729b50721578484098564f5a4fd4eb5193d0fc88177bcdb"

  bottle do
    cellar :any
    sha256 "7eb7b31f22fa4cfdbae9c2786fb8879d4543111476cd3faeb80985f3b0ae3fc7" => :sierra
    sha256 "75afd33e92c992aee692f441ef28bf64174f82bf8047efb36255c1c438e64364" => :el_capitan
    sha256 "554f350cbdbd7588de66b6e760686c55eca53b81f99128b3f36e3ea4f921e9f3" => :yosemite
=======
  url "https://mediaarea.net/download/binary/mediaconch/17.04/MediaConch_CLI_17.04_GNU_FromSource.tar.bz2"
  version "17.04"
  sha256 "28bb2781ddf67041a5bbf90ee7368725f01a66d813b60da96f9ff9d6f2233d94"

  bottle do
    cellar :any
    sha256 "f1d00bb4bc0adb9d3f211b551d8a61b00e91a23443a4a960b6912be40aedd1bb" => :sierra
    sha256 "d996f12c6338d4f0b46e7c8476cd56f959c4497747b72d2ab7b19083dcb2feac" => :el_capitan
    sha256 "7043592c8a2c3c92246baf4d4dc7277279ff629664cf7e6207faa1b43b4f1e57" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "pkg-config" => :build
  depends_on "jansson"
  depends_on "libevent"
  depends_on "sqlite"
<<<<<<< HEAD
  # fails to build against Leopard's older libcurl
  depends_on "curl" if MacOS.version < :snow_leopard
=======
>>>>>>> kettle: fix hardcoded /usr/local idiocy.

  def install
    cd "ZenLib/Project/GNU/Library" do
      args = ["--disable-debug",
              "--disable-dependency-tracking",
              "--enable-shared",
              "--enable-static",
              "--prefix=#{prefix}",
              # mediaconch installs libs/headers at the same paths as mediainfo
              "--libdir=#{lib}/mediaconch",
              "--includedir=#{include}/mediaconch"]
      system "./configure", *args
      system "make", "install"
    end

    cd "MediaInfoLib/Project/GNU/Library" do
      args = ["--disable-debug",
              "--disable-dependency-tracking",
              "--enable-static",
              "--enable-shared",
              "--with-libcurl",
              "--prefix=#{prefix}",
              "--libdir=#{lib}/mediaconch",
              "--includedir=#{include}/mediaconch"]
      system "./configure", *args
      system "make", "install"
    end

    cd "MediaConch/Project/GNU/CLI" do
      system "./configure", "--disable-debug", "--disable-dependency-tracking",
                            "--prefix=#{prefix}"
      system "make", "install"
    end
  end

  test do
    pipe_output("#{bin}/mediaconch", test_fixtures("test.mp3"))
  end
end
