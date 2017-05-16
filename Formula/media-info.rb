class MediaInfo < Formula
  desc "Unified display of technical and tag data for audio/video"
  homepage "https://mediaarea.net/"
<<<<<<< HEAD
  url "https://mediaarea.net/download/binary/mediainfo/0.7.94/MediaInfo_CLI_0.7.94_GNU_FromSource.tar.bz2"
  version "0.7.94"
  sha256 "af32c03b1c9ab62a35d5e486bbc8988fd1c764abcb6d1a89402235cd5b16546f"

  bottle do
    cellar :any
    sha256 "3a586fac4e237c89c57ff7ff6247ef7cb28b383ea24f019e2f1d98662de87492" => :sierra
    sha256 "0657b3ef7849fac6c7db740da7b089dea48d41e29cf1047796419537c891845c" => :el_capitan
    sha256 "09b6188c0752c67d49b24d6cde70ffcf09f06047a5d157e0c5f095f93b12674f" => :yosemite
  end

  depends_on "pkg-config" => :build
  # fails to build against Leopard's older libcurl
  depends_on "curl" if MacOS.version < :snow_leopard
=======
  url "https://mediaarea.net/download/binary/mediainfo/0.7.95/MediaInfo_CLI_0.7.95_GNU_FromSource.tar.bz2"
  version "0.7.95"
  sha256 "8e5a88a3610e18cbc8905d796f1b29828767354a538ff4836056420632a47978"

  bottle do
    cellar :any
    sha256 "fb1ed23063b8a28542ccc458a031dd93b078d67b073275894977188dbbccb55f" => :sierra
    sha256 "6eb28d8271ff602f8d37f57699a2c3f3f4b59500ec788e94ef3a2e9aceb57ba0" => :el_capitan
    sha256 "f42d62119fdd4c515e850b72ee6a9ef7a844185855c15fed2ec0934efd6c3eef" => :yosemite
  end

  depends_on "pkg-config" => :build
>>>>>>> kettle: fix hardcoded /usr/local idiocy.

  def install
    cd "ZenLib/Project/GNU/Library" do
      args = ["--disable-debug",
              "--disable-dependency-tracking",
              "--enable-static",
              "--enable-shared",
              "--prefix=#{prefix}"]
      system "./configure", *args
      system "make", "install"
    end

    cd "MediaInfoLib/Project/GNU/Library" do
      args = ["--disable-debug",
              "--disable-dependency-tracking",
              "--with-libcurl",
              "--enable-static",
              "--enable-shared",
              "--prefix=#{prefix}"]
      system "./configure", *args
      system "make", "install"
    end

    cd "MediaInfo/Project/GNU/CLI" do
      system "./configure", "--disable-debug", "--disable-dependency-tracking",
                            "--prefix=#{prefix}"
      system "make", "install"
    end
  end

  test do
    pipe_output("#{bin}/mediainfo", test_fixtures("test.mp3"))
  end
end
