class Duck < Formula
  desc "Command-line interface for Cyberduck (a multi-protocol file transfer tool)"
  homepage "https://duck.sh/"
  # check the changelog for the latest stable version: https://cyberduck.io/changelog/
<<<<<<< HEAD
  url "https://dist.duck.sh/duck-src-5.3.8.23611.tar.gz"
  sha256 "809b94dd1689a3b8473fe4e0ee329068aa361de82cf060cde9d3a0a2696f43f0"
  head "https://svn.cyberduck.io/trunk/"

  bottle do
    sha256 "81bdff2dedcef593430a3fe22474f9d96036c8bd91229117311a91beea8f65f9" => :sierra
    sha256 "cde2cc8f04fde06bf0b3a8629eb5b6505b3ef6b3d956145ae0ea739936f1e774" => :el_capitan
    sha256 "db301fd94421e00950a3077ffb3e7895ea34e9ecd5b31264d2cce7a7667aa06b" => :yosemite
=======
  url "https://dist.duck.sh/duck-src-6.0.0.24625.tar.gz"
  sha256 "ea9ac134fa3146822fced3da34f56154616993008707e74e8fc0733e7617425e"
  head "https://svn.cyberduck.io/trunk/"

  bottle do
    sha256 "84dec700b5a045ca32bfcac095a515c118a2636e14826d6891d7bff2a1fb5eec" => :sierra
    sha256 "ff34e3c14192e8eb551a5b005edada07a4621491bf957a94840ee0564f79477b" => :el_capitan
    sha256 "49e8908c6ff03e2410ed3b8c4bc67f7acc367b41cb447720c693887ba225464d" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on :java => ["1.8+", :build]
  depends_on :xcode => :build
  depends_on "ant" => :build
  depends_on "maven" => :build

  def install
    ENV.java_cache
    revision = version.to_s.rpartition(".").last
    system "mvn", "-DskipTests", "-Dgit.commitsCount=#{revision}", "--projects", "cli/osx", "--also-make", "verify"
    libexec.install Dir["cli/osx/target/duck.bundle/*"]
    bin.install_symlink "#{libexec}/Contents/MacOS/duck" => "duck"
  end

  test do
    system "#{bin}/duck", "--download", Formula["wget"].stable.url, testpath/"test"
    (testpath/"test").verify_checksum Formula["wget"].stable.checksum
  end
end
