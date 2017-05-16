class Hyper < Formula
  desc "Client for the Hyper_ cloud service"
  homepage "https://hyper.sh"
  url "https://github.com/hyperhq/hypercli.git",
<<<<<<< HEAD
    :tag => "v1.10.9",
    :revision => "1ed5d3fd838860558b757336b578fcb9bfb22499"
=======
    :tag => "v1.10.10",
    :revision => "a94e549f5f7ebfb23323ff79ad7304e59f1cca77"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.

  head "https://github.com/hyperhq/hypercli.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "11144e075470152acb855461e77ace302cd225844c5898e906b1a23c68cc251f" => :sierra
    sha256 "418e6d199cfce7a412a310bfb9b5f6f8c195d4b6a66f29a982f32fc0d0c8221b" => :el_capitan
    sha256 "75630cea940a7e7c37a26d2e1151b9fe4306ff7e8f3e24aecf92345df8910af4" => :yosemite
=======
    sha256 "43a75f74013fd56a40eade63d34ee982368b796c7e4847e9702948981a926c65" => :sierra
    sha256 "d42ad5d4ffb61146e2ed98833bd614327eb519c7d2bf0629eedbdf3e8c867aed" => :el_capitan
    sha256 "8e379a80d90195d88cd2a62b19d9c1ea111c670dc0819f47a436748601652759" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    mkdir_p "src/github.com/hyperhq"
    ln_s buildpath, "src/github.com/hyperhq/hypercli"
    system "./build.sh"
    bin.install "hyper/hyper"
  end

  test do
    system "#{bin}/hyper", "--help"
  end
end
