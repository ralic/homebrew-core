class OpencoreAmr < Formula
  desc "Audio codecs extracted from Android open source project"
  homepage "https://opencore-amr.sourceforge.io/"
<<<<<<< HEAD
  url "https://downloads.sourceforge.net/opencore-amr/opencore-amr-0.1.4.tar.gz"
  sha256 "029918505e6a357b2b09432c7892a192d740d8b82f8a44c2e0805ba45643a95b"

  bottle do
    cellar :any
    sha256 "425fbe7604961f21ac05150585e77311094159ffe13b1ce2de816f36482482ad" => :sierra
    sha256 "92bdd75efff4d4c94822847d9ddda34a70abd8dec5a28c6875b071394d31b7a6" => :el_capitan
    sha256 "c97e0859a55c074d5679d7fc63df608041ae8258d737cb56cfad997f8c82eba2" => :yosemite
=======
  url "https://downloads.sourceforge.net/opencore-amr/opencore-amr-0.1.5.tar.gz"
  sha256 "2c006cb9d5f651bfb5e60156dbff6af3c9d35c7bbcc9015308c0aff1e14cd341"

  bottle do
    cellar :any
    sha256 "2b6378d4427dc88bac7e01d2614dd100535f1d78b1e6b81560e3a074e1d5a770" => :sierra
    sha256 "4b628ad01f725342698a8556c4176f5d57e3647cc0f52669092a0523b76cc5d0" => :el_capitan
    sha256 "0e8940ad28407b353c69b7fa0cdcd7d90777345f5ea86dcc9974552f99c1030c" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end
end
