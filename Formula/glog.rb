class Glog < Formula
  desc "Application-level logging library"
  homepage "https://github.com/google/glog"
<<<<<<< HEAD
  url "https://github.com/google/glog/archive/v0.3.4.tar.gz"
  sha256 "ce99d58dce74458f7656a68935d7a0c048fa7b4626566a71b7f4e545920ceb10"
=======
  url "https://github.com/google/glog/archive/v0.3.5.tar.gz"
  sha256 "7580e408a2c0b5a89ca214739978ce6ff480b5e7d8d7698a2aa92fadc484d1e0"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  revision 1

  bottle do
    cellar :any
<<<<<<< HEAD
    sha256 "ba281274fae4fe2d690ee8da9c2760127541766e7cdf8674f298adb8e1da9ee7" => :sierra
    sha256 "48f7420d05c130c6df1a507d217d472cf25ffaa670685a2d94c98fefe26c40d2" => :el_capitan
    sha256 "e088fb40a28364979695cec6318bd10b6d3d5d3ac7a5ead6c494bda6fb6b1d21" => :yosemite
=======
    sha256 "c5ed5359196732957cfabbe516c87437df4969547471d8ba6dff78414ab0feb8" => :sierra
    sha256 "2a7a2aef322dfd7431221bb8b5807c67d06bbe8d6407d44ed6cedceda8a45098" => :el_capitan
    sha256 "ccb8f5022bffec4a768851feb5a8cc1bf52ee7d9b8b87b8f9ce6bc4cd28278f9" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "gflags"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
