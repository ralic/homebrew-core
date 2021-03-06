class Ponyc < Formula
  desc "Object-oriented, actor-model, capabilities-secure programming language"
  homepage "https://www.ponylang.org/"
<<<<<<< HEAD
  url "https://github.com/ponylang/ponyc/archive/0.13.2.tar.gz"
  sha256 "2e01a64e93c29adad3553a12188a20bfcfbb3f3a35f4a15f867d730cff13a34f"

  bottle do
    cellar :any
    sha256 "54b64a772419eb29d21232075706dd23b16da31c51e4eccb9dcee6d82e23c57f" => :sierra
    sha256 "dcaf5ca9003822d2e95970095c2c1a8d86c4f91ef09a7c6ab7e045493918223b" => :el_capitan
    sha256 "ef450e6d4768ea59dfc5035e86e6ad613a235b750ffa27a89a55a3e732f4eb6a" => :yosemite
=======
  url "https://github.com/ponylang/ponyc/archive/0.14.0.tar.gz"
  sha256 "4a7d05c1b8e6c681c6ee89653b75e0de382176408dc192e3bab2853f812f9dad"

  bottle do
    cellar :any
    sha256 "7684bb5b7a6cb9c1af9f3e75ee1587fae90b855a93f541d14276dcbefa544755" => :sierra
    sha256 "bcdb5927f2c39695680dedca80c5e4e658d7c9d2ccf21b7a16d79091eadabee6" => :el_capitan
    sha256 "882b15cc0df05bee001e44c3b95c9ff77fe554bd8cb8923498ba4071cdae6695" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on :macos => :yosemite
  depends_on "llvm@3.9"
  depends_on "libressl"
  depends_on "pcre2"
  needs :cxx11

  # https://github.com/ponylang/ponyc/issues/1274
  # https://github.com/Homebrew/homebrew-core/issues/5346
  pour_bottle? do
    reason <<-EOS.undent
      The bottle requires Xcode/CLT 8.0 or later to work properly.
    EOS
    satisfy { DevelopmentTools.clang_build_version >= 800 }
  end

  def install
    ENV.cxx11
    ENV["LLVM_CONFIG"] = "#{Formula["llvm@3.9"].opt_bin}/llvm-config"
    system "make", "config=release", "destdir=#{prefix}", "install", "verbose=1"
  end

  test do
    system "#{bin}/ponyc", "-rexpr", "#{prefix}/packages/stdlib"

    (testpath/"test/main.pony").write <<-EOS.undent
    actor Main
      new create(env: Env) =>
        env.out.print("Hello World!")
    EOS
    system "#{bin}/ponyc", "test"
    assert_equal "Hello World!", shell_output("./test1").strip
  end
end
