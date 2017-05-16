class Convox < Formula
  desc "The convox AWS PaaS CLI tool"
  homepage "https://convox.com/"
<<<<<<< HEAD
  url "https://github.com/convox/rack/archive/20170501192321.tar.gz"
  sha256 "34113267a96eb0175345eb6c4d6e7d0d2d961559a8232415b6f977fd9bf6ce6d"

  bottle do
    cellar :any_skip_relocation
    sha256 "ccafc5da2a76d6a507990b14842ac0cc1d230842239ddedb931fd112bc7d261c" => :sierra
    sha256 "28e75b9b0ec4fd28ff1374fea3633af2a0f7e0da5cdbc7f9c5f9be01633aa175" => :el_capitan
    sha256 "e6bc86e71179acd4fcf0fa3c12fa2f7571e9408da0801997ae440be6e7dec9ff" => :yosemite
=======
  url "https://github.com/convox/rack/archive/20170508213441.tar.gz"
  sha256 "74860e3aff62449c0398c3c01cfd448857be35fd8bea4286ce657494331047d8"

  bottle do
    cellar :any_skip_relocation
    sha256 "3794f3cc0db1f4e73d4e6da8bde8828e3d191dd965a2f525203795aedf1ba4e5" => :sierra
    sha256 "04c5bbd47e64971a15f9aaab75459504ccc34036fea34a9256fa03e46c11ae7a" => :el_capitan
    sha256 "80e7b536ef953031707842e703f588e230e644226a54d9cabb5ad18fb4f9d210" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/convox/rack").install Dir["*"]
    system "go", "build", "-ldflags=-X main.Version=#{version}",
           "-o", bin/"convox", "-v", "github.com/convox/rack/cmd/convox"
  end

  test do
    system bin/"convox"
  end
end
