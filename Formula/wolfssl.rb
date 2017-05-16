class Wolfssl < Formula
  desc "Embedded SSL Library written in C"
  homepage "https://www.wolfssl.com/wolfSSL/Home.html"
<<<<<<< HEAD
  url "https://github.com/wolfSSL/wolfssl/archive/v3.10.2-stable.tar.gz"
  version "3.10.2"
  sha256 "2107635718d25f1aafbeb8b07513ed5feda9afc42de7ce0f2508ce17f2a06b9e"
=======
  url "https://github.com/wolfSSL/wolfssl/archive/v3.11.0-stable.tar.gz"
  version "3.11.0"
  sha256 "353a7bd21ef52ae25b7d35d46f5c46931be492eceb724a6e9791c20343e08311"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/wolfSSL/wolfssl.git"

  bottle do
    cellar :any
<<<<<<< HEAD
    sha256 "acffe8bd2e2f66d4f0e6ff2142c1de4862e0d579f4ab5e07b8a5bb30c0c5e8d4" => :sierra
    sha256 "64c3657983dcc62107377fa4a1d1ea457c3f5e307dc97735bd1d62bec54a9ae1" => :el_capitan
    sha256 "ac3b5d22ca120bb575ee3a00f1e7dd86d85805bebd03398dedabc2fb4115afd6" => :yosemite
=======
    sha256 "c1802e779f2b066dbcf996fed2775a17386f0dc9a926c681cef14f535fbaf826" => :sierra
    sha256 "54dad3fb7fb6df86596f00cfc0d25c2ec16d34271018582c513271eabc34ea39" => :el_capitan
    sha256 "e4aa4999d6d37f1ee8a342a1560b7fb802ef6c913270eb7cd068ba954c818c18" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  option "without-test", "Skip compile-time tests"

  deprecated_option "without-check" => "without-test"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    # https://github.com/Homebrew/homebrew-core/pull/1046
    # https://github.com/Homebrew/brew/pull/251
    ENV.delete("SDKROOT")

    args = %W[
      --disable-silent-rules
      --disable-dependency-tracking
      --infodir=#{info}
      --mandir=#{man}
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --disable-bump
      --disable-examples
      --disable-fortress
      --disable-md5
      --disable-sniffer
      --disable-webserver
      --enable-aesccm
      --enable-aesgcm
      --enable-alpn
      --enable-blake2
      --enable-camellia
      --enable-certgen
      --enable-certreq
      --enable-chacha
      --enable-crl
      --enable-crl-monitor
      --enable-curve25519
      --enable-dtls
      --enable-dh
      --enable-ecc
      --enable-eccencrypt
      --enable-ed25519
      --enable-filesystem
      --enable-hc128
      --enable-hkdf
      --enable-inline
      --enable-ipv6
      --enable-jni
      --enable-keygen
      --enable-ocsp
      --enable-opensslextra
      --enable-poly1305
      --enable-psk
      --enable-rabbit
      --enable-ripemd
      --enable-savesession
      --enable-savecert
      --enable-sessioncerts
      --enable-sha512
      --enable-sni
      --enable-supportedcurves
    ]

    if MacOS.prefer_64_bit?
      args << "--enable-fastmath" << "--enable-fasthugemath"
    else
      args << "--disable-fastmath" << "--disable-fasthugemath"
    end

    args << "--enable-aesni" if Hardware::CPU.aes? && !build.bottle?

    # Extra flag is stated as a needed for the Mac platform.
    # https://wolfssl.com/wolfSSL/Docs-wolfssl-manual-2-building-wolfssl.html
    # Also, only applies if fastmath is enabled.
    ENV.append_to_cflags "-mdynamic-no-pic" if MacOS.prefer_64_bit?

    system "./autogen.sh"
    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end

  test do
    system bin/"wolfssl-config", "--cflags", "--libs", "--prefix"
  end
end
