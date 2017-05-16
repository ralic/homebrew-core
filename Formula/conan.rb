class Conan < Formula
  include Language::Python::Virtualenv

  desc "Distributed, open source, package manager for C/C++"
  homepage "https://github.com/conan-io/conan"
<<<<<<< HEAD
  url "https://github.com/conan-io/conan/archive/0.22.2.tar.gz"
  sha256 "017e7cfa3a8e72910410d343fe26af01965a8c013ce6a749c7126805d7adb769"
=======
  url "https://github.com/conan-io/conan/archive/0.22.3.tar.gz"
  sha256 "cb38e0926dbb2605ba3ae86a5f7bd36c155c7bd449baa0863bcc1051f4e546b1"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/conan-io/conan.git"

  bottle do
    cellar :any
<<<<<<< HEAD
    sha256 "beac159a74cc6efe62edd91a46a17707c9b37bc5610063307ff7aba2c7b13829" => :sierra
    sha256 "4b84b32ea940d31994efd6247fc354743b41c27c2e1d812ec8d6a88d0d0d3e5f" => :el_capitan
    sha256 "0f4339f38a483a88925a699508122b623a552c33b460df3368e87f5c5b004b37" => :yosemite
=======
    sha256 "1b6956e11c5594535f4e5f04c062032cc6dc8b5195248d6efec1634223d2cfb4" => :sierra
    sha256 "1a44b20dfbc846b26b06587e3a1a28ace649a03ec08fad058c18f321a7a473ba" => :el_capitan
    sha256 "6b5c686f5f0a67ae5ad23a143086f289ed86f93a0c689909b67d1078ed0cc748" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "pkg-config" => :build
  depends_on :python if MacOS.version <= :snow_leopard
  depends_on "libffi"
  depends_on "openssl"

  def install
    venv = virtualenv_create(libexec)
    system libexec/"bin/pip", "install", "-v", "--no-binary", ":all:",
                              "--ignore-installed", buildpath
    system libexec/"bin/pip", "uninstall", "-y", name
    venv.pip_install_and_link buildpath
  end

  test do
    system bin/"conan", "install", "zlib/1.2.8@lasote/stable", "--build"
    assert_predicate testpath/".conan/data/zlib/1.2.8", :exist?
  end
end
