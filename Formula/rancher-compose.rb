class RancherCompose < Formula
  desc "Docker Compose compatible client to deploy to Rancher"
  homepage "https://github.com/rancher/rancher-compose"
<<<<<<< HEAD
  url "https://github.com/rancher/rancher-compose/archive/v0.12.4.tar.gz"
  sha256 "67c46e4c491ea1fd6fb784bf8be1aa4cb8cfa3bc0333bb2138a70e1a28f13eae"

  bottle do
    cellar :any_skip_relocation
    sha256 "e56f25978bdca34c4efb81784b0e2eadcbfd6fe38fcb959c8ee384b01912e7f6" => :sierra
    sha256 "cccb6ffd58081b83cf7af403b4060b1b0288c616f0fa1ed673524bbb9e54f4c1" => :el_capitan
    sha256 "d93258159883c058f7b6c90cfac71547b31a08c8121ee832985b19d757b770fa" => :yosemite
=======
  url "https://github.com/rancher/rancher-compose/archive/v0.12.5.tar.gz"
  sha256 "cdff53b2c3401b990ad33e229c7ef429504419e49e18a814101e2fa3c84859ea"

  bottle do
    cellar :any_skip_relocation
    sha256 "08f3fad4e6c1df545dd908b61afe47ed489e682ad2cadab384066237498a2a04" => :sierra
    sha256 "8503ea7d7ca208ca7fe8d0c0b81f9ab9b69d926c58f856ac9de4f9f3600cde17" => :el_capitan
    sha256 "23291133a0a775210ae1244ae594931ce04fab8e7c0a37ba90431d61d869317b" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/rancher/rancher-compose").install Dir["*"]
    system "go", "build", "-ldflags",
           "-w -X github.com/rancher/rancher-compose/version.VERSION=#{version}",
           "-o", "#{bin}/rancher-compose",
           "-v", "github.com/rancher/rancher-compose"
    prefix.install_metafiles "src/github.com/rancher/rancher-compose"
  end

  test do
    system bin/"rancher-compose", "help"
  end
end
