class ConsulTemplate < Formula
  desc "Generic template rendering and notifications with Consul"
  homepage "https://github.com/hashicorp/consul-template"
  url "https://github.com/hashicorp/consul-template.git",
<<<<<<< HEAD
      :tag => "v0.18.2",
      :revision => "770d6514fcb34703b594280d73fc5427fe692f1b"
=======
      :tag => "v0.18.3",
      :revision => "3a31dde7d5dbddf2555470021f3e18985f1edd9d"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/hashicorp/consul-template.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "4810a80f495db526959e6f830cf95c6d219b99ddb4915e934b98797bd95552e0" => :sierra
    sha256 "4a131cec77f31b38e8821372adc7f2196cfe7723613c53db41f6cd1c4dfc68bd" => :el_capitan
    sha256 "2e56bcf8fff635631457330a43ee4e5f24901102674020958b5698fbd5c3598e" => :yosemite
=======
    sha256 "aa4acaaff0f85ee7b7860e3b18746d0404657a1c9244999817e06f52c145bf6e" => :sierra
    sha256 "451ae2b901a7d1f28398dbe2be704257869b8e37f89f173bf072adae6a8418e9" => :el_capitan
    sha256 "cf358ac82b4c6ca739ac62b5d1eb092902a5d3d6d38f22b600c9491c3abfd114" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    arch = MacOS.prefer_64_bit? ? "amd64" : "386"
    ENV["XC_OS"] = "darwin"
    ENV["XC_ARCH"] = arch
    dir = buildpath/"src/github.com/hashicorp/consul-template"
    dir.install buildpath.children - [buildpath/".brew_home"]

    cd dir do
      system "make", "bin-local"
      bin.install "pkg/darwin_#{arch}/consul-template"
    end
  end

  test do
    (testpath/"template").write <<-EOS.undent
      {{"homebrew" | toTitle}}
    EOS
    system bin/"consul-template", "-once", "-template", "template:test-result"
    assert_equal "Homebrew", (testpath/"test-result").read.chomp
  end
end
