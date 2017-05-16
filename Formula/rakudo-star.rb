class RakudoStar < Formula
  desc "Perl 6 compiler"
  homepage "http://rakudo.org/"
<<<<<<< HEAD
  url "http://rakudo.org/downloads/star/rakudo-star-2017.01.tar.gz"
  sha256 "583a91f21fd65e50df6e60ea047c8d4baf725a32265bcab1ac178cda7fc3f21f"

  bottle do
    sha256 "5cfef784285a5e46be149ebfc07cef95b41b9162e6925067dd6351ed1b37b4ed" => :sierra
    sha256 "4b4004ef1db0bee289176404a36611a987c362b92489ddbb46e5173c5b366099" => :el_capitan
    sha256 "99334acafe6eec093891ed0bfc17173c4a6e3dceb0722bb89edabb1f3d089726" => :yosemite
=======
  url "http://rakudo.org/downloads/star/rakudo-star-2017.04.tar.gz"
  sha256 "731ddb63f17bf211b2bf2681fdb7aefc6fe1161dbaab0831d93de4a854153018"

  bottle do
    sha256 "b816c1150120abc3d5acc4d1ca233b7e5ce6daabb302f152cd6ce51e8a0b68b6" => :sierra
    sha256 "495e76ed9c925686a0a7d5487dbb4ad47ac21351c425255735b6efee88742b4d" => :el_capitan
    sha256 "9c8d50de0cd4441d44458657be33779027d12da855da32fc0d516c812340770c" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  option "with-jvm", "Build also for jvm as an alternate backend."

  depends_on "gmp" => :optional
  depends_on "icu4c" => :optional
  depends_on "pcre" => :optional
  depends_on "libffi"

  conflicts_with "parrot"

  def install
    libffi = Formula["libffi"]
    ENV.remove "CPPFLAGS", "-I#{libffi.include}"
    ENV.prepend "CPPFLAGS", "-I#{libffi.lib}/libffi-#{libffi.version}/include"

    ENV.deparallelize # An intermittent race condition causes random build failures.

    backends = ["moar"]
    generate = ["--gen-moar"]

    backends << "jvm" if build.with? "jvm"

    system "perl", "Configure.pl", "--prefix=#{prefix}", "--backends=" + backends.join(","), *generate
    system "make"
    system "make", "install"

    # Panda is now in share/perl6/site/bin, so we need to symlink it too.
    bin.install_symlink Dir[share/"perl6/site/bin/*"]

    # Move the man pages out of the top level into share.
    # Not all backends seem to generate man pages at this point (moar does not, parrot does),
    # so we need to check if the directory exists first.
    if File.directory?("#{prefix}/man")
      mv "#{prefix}/man", share
    end
  end

  test do
    out = `#{bin}/perl6 -e 'loop (my $i = 0; $i < 10; $i++) { print $i }'`
    assert_equal "0123456789", out
    assert_equal 0, $?.exitstatus
  end
end
