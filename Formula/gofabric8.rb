class Gofabric8 < Formula
  desc "CLI for fabric8 running on Kubernetes or OpenShift"
  homepage "https://github.com/fabric8io/gofabric8/"
<<<<<<< HEAD
  url "https://github.com/fabric8io/gofabric8/archive/v0.4.121.tar.gz"
  sha256 "9fc6656150e84d469ad9f37cf0e43b2afa146acb4d9f92e7de368ea7ac9075e5"

  bottle do
    cellar :any_skip_relocation
    sha256 "374a5757c1c3f8ef4531d9d921213c211ac9a863f48c301959cd4d69d0436c0f" => :sierra
    sha256 "ec4feb35e586cfb5b67a51aaf5adda167a6732d4bc267c8d6fbb1e676eba2b6b" => :el_capitan
    sha256 "8077f8bf1027d5510475ea1c38a2719954092ba2c715efc446ec823d3a6ac8f0" => :yosemite
=======
  url "https://github.com/fabric8io/gofabric8/archive/v0.4.122.tar.gz"
  sha256 "ab9e0ba8ec19e8156f13d191f84546209eba8b8fc1e60ac716eed407a63384ec"

  bottle do
    cellar :any_skip_relocation
    sha256 "2f5d5bd9d12dce12f5f6eada726000fdab2068a410dcaebf179752ead28eaa9c" => :sierra
    sha256 "c90a08ed921669235f5db4a18784ad561f330e3e40b71f8a37b6302cd072955a" => :el_capitan
    sha256 "5ecd0b6ee64612bc0985ef8e7921c35475c62d3b50b58b916adbfc0337b676af" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    dir = buildpath/"src/github.com/fabric8io/gofabric8"
    dir.install buildpath.children

    cd dir do
      system "make", "install", "REV=homebrew"
      prefix.install_metafiles
    end

    bin.install "bin/gofabric8"
  end

  test do
    Open3.popen3("#{bin}/gofabric8", "version") do |stdin, stdout, _|
      stdin.puts "N" # Reject any auto-update prompts
      stdin.close
      assert_match "gofabric8, version #{version} (branch: 'unknown', revision: 'homebrew')", stdout.read
    end
  end
end
