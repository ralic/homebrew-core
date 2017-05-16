class Davix < Formula
  desc "Library and tools for advanced file I/O with HTTP-based protocols"
  homepage "https://dmc.web.cern.ch/projects/davix/home"
  url "https://github.com/cern-it-sdc-id/davix.git",
<<<<<<< HEAD
    :revision => "3489ad37c09d002283ccb42d55dc9beca4a1fe1a",
    :tag => "R_0_6_5"
  version "0.6.5"

=======
      :tag => "R_0_6_6",
      :revision => "32c5f3cf934500a570703c8f6bfc06ede10ed4b8"
  version "0.6.6"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/cern-it-sdc-id/davix.git"

  bottle do
    cellar :any
<<<<<<< HEAD
    sha256 "a29932da10389d7ca84aae0b027ce6569e15079c91d390efc2b2205fdf83db2f" => :sierra
    sha256 "dfe15dab9d440ceecf2ab2aa21fc905d16521de72c59c581748bddf706152afe" => :el_capitan
    sha256 "df5889e6dcee1cd77d94857c4bbcfd143add707af36c72e1f16ba9cf806a3f2b" => :yosemite
=======
    sha256 "58b587ea2528b80f1fd134c54cd200d3cbbbbf5ef433f6430d8f6c74f8af085a" => :sierra
    sha256 "f595758a61ba591a8b746a4f22336f19abecbbe881ad4e0e7cbec458d13184a8" => :el_capitan
    sha256 "6304f894a261384a80a25838e88bea83a63f753b645dc1c4550d78993fc2fee0" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "openssl"
<<<<<<< HEAD
=======
  depends_on "ossp-uuid"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.

  def install
    ENV.libcxx

    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "#{bin}/davix-get", "https://www.google.com"
  end
end
