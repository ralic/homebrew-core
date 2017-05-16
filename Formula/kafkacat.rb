class Kafkacat < Formula
  desc "Generic command-line non-JVM Apache Kafka producer and consumer"
  homepage "https://github.com/edenhill/kafkacat"
  url "https://github.com/edenhill/kafkacat.git",
      :tag => "1.3.1",
      :revision => "0ab52045cde0c16f9f99dad41cee019ff88e974e"
<<<<<<< HEAD

  bottle do
    cellar :any
    sha256 "dad8f463c25cc6b481e9205485f1496689b23ea0a4fd208409588508d610ee7c" => :sierra
    sha256 "5bc56f600f522ff0e4b90e46b73c3fe689fe4fd8a89de277256af68b5303cdbd" => :el_capitan
    sha256 "c19822fe3aeea1c75ae42ab5947fd9178716501e842438f05bed7b80c2e8805d" => :yosemite
  end

  option "with-yajl", "Adds JSON support"

  depends_on "librdkafka"
  depends_on "yajl" => :optional

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
    ]

    args << "--enable-json" if build.with?("yajl")

    system "./configure", *args
=======
  revision 1

  bottle do
    cellar :any
    sha256 "14038aa18ab2f7f982000b3a5ad347f9519809b3bab0cfe47424bb73f333de6e" => :sierra
    sha256 "ef21329872a809c9a01e6361fcc2d0830f5b9c33455286260b45713acf19285f" => :el_capitan
    sha256 "cc9011d799bd2dfcb514c9ac499bda051e14a30f73ea8884048fa3d1337ceb47" => :yosemite
  end

  depends_on "librdkafka"
  depends_on "yajl"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-json"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
    system "make"
    system "make", "install"
  end

  test do
    system bin/"kafkacat", "-X", "list"
  end
end
