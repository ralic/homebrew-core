class Cmake < Formula
  desc "Cross-platform make"
  homepage "https://www.cmake.org/"
<<<<<<< HEAD
  url "https://cmake.org/files/v3.8/cmake-3.8.0.tar.gz"
  sha256 "cab99162e648257343a20f61bcd0b287f5e88e36fcb2f1d77959da60b7f35969"
=======
  url "https://cmake.org/files/v3.8/cmake-3.8.1.tar.gz"
  sha256 "ce5d9161396e06501b00e52933783150a87c33080d4bdcef461b5b7fd24ac228"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://cmake.org/cmake.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "570aff0119b18df8ef05961b699e4ee592338eed62e29b25b200e44116c9a470" => :sierra
    sha256 "5a8aadff20e81935a377c9b58489ec37aa8abe72abfa361fda9b44bac843253b" => :el_capitan
    sha256 "96d1beeec8afbd200a79298adefb8e235b179dea56241ebec6707080ca982fbc" => :yosemite
=======
    sha256 "4f315f8f2bf0d6727c7724ab4d55d91a28ec0043ac3fc799989a88ff8ff104a7" => :sierra
    sha256 "faa87738bfdc8af63e8bc98e41f5c81b25015ea94b02c94865132511203eadeb" => :el_capitan
    sha256 "88af0fd8c30ed07b23ab64a59ad59478c686d459765de85f4de14b4a210a64f8" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  option "without-docs", "Don't build man pages"
  option "with-completion", "Install Bash completion (Has potential problems with system bash)"

  depends_on "sphinx-doc" => :build if build.with? "docs"

  # The `with-qt` GUI option was removed due to circular dependencies if
  # CMake is built with Qt support and Qt is built with MySQL support as MySQL uses CMake.
  # For the GUI application please instead use `brew cask install cmake`.

  def install
    args = %W[
      --prefix=#{prefix}
      --no-system-libs
      --parallel=#{ENV.make_jobs}
      --datadir=/share/cmake
      --docdir=/share/doc/cmake
      --mandir=/share/man
      --system-zlib
      --system-bzip2
<<<<<<< HEAD
    ]

    # https://github.com/Homebrew/legacy-homebrew/issues/45989
    if MacOS.version <= :lion
      args << "--no-system-curl"
    else
      args << "--system-curl"
    end

=======
      --system-curl
    ]

>>>>>>> kettle: fix hardcoded /usr/local idiocy.
    if build.with? "docs"
      # There is an existing issue around macOS & Python locale setting
      # See https://bugs.python.org/issue18378#msg215215 for explanation
      ENV["LC_ALL"] = "en_US.UTF-8"
      args << "--sphinx-man" << "--sphinx-build=#{Formula["sphinx-doc"].opt_bin}/sphinx-build"
    end

    system "./bootstrap", *args
    system "make"
    system "make", "install"

    if build.with? "completion"
      cd "Auxiliary/bash-completion/" do
        bash_completion.install "ctest", "cmake", "cpack"
      end
    end

    elisp.install "Auxiliary/cmake-mode.el"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(Ruby)")
    system bin/"cmake", "."
  end
end
