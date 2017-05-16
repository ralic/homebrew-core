class RancherCli < Formula
  desc "The Rancher CLI is a unified tool to manage your Rancher server"
  homepage "https://github.com/rancher/cli"
<<<<<<< HEAD
  url "https://github.com/rancher/cli/archive/v0.5.2.tar.gz"
  sha256 "4b7bd71f9f23e465e61c1cd5fd97957fff3265fad6e90ca51c48322bede9108b"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "71760f831ccd1412abf80a55552b6ffa9d6969978b6276c55fcad9c08d772347" => :sierra
    sha256 "e655ca5d947070eb4420b188abcce3ae8cc5617ad479c7d353a3292072f5bfe8" => :el_capitan
    sha256 "03ddb1de924422d62d05200f1f735ff94626dcde3a704fc4cf09dd63262866fa" => :yosemite
=======
  url "https://github.com/rancher/cli/archive/v0.6.0.tar.gz"
  sha256 "278ddb2e967a4936eb45a0b303226b5a3b3cd7c1e4a220c162fef44d79637caf"

  bottle do
    cellar :any_skip_relocation
    sha256 "a439d2b4ff8896b3a4f31764649d3427291f1600b496ae8ed6880cc9d9041d3a" => :sierra
    sha256 "9ee696182677a9706120abd2855837c21dc022dd66543329426340f74a9a65d7" => :el_capitan
    sha256 "a28bb0be6e94acb314755eebcef75bd269aa9feb754d1396ff6bbba389482aab" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/rancher/cli/").install Dir["*"]
    system "go", "build", "-ldflags",
           "-w -X github.com/rancher/cli/version.VERSION=#{version}",
           "-o", "#{bin}/rancher",
           "-v", "github.com/rancher/cli/"
  end

  test do
    system bin/"rancher", "help"
  end
end
