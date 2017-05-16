class Hugo < Formula
  desc "Configurable static site generator"
  homepage "https://gohugo.io/"
<<<<<<< HEAD
  url "https://github.com/spf13/hugo/archive/v0.20.6.tar.gz"
  sha256 "857655b69fb3e7f174011fd6774501194f1241bbb833256fd63b585b6d7a3cc0"
=======
  url "https://github.com/spf13/hugo/archive/v0.20.7.tar.gz"
  sha256 "81b0fa0743f8f075c76c7c0d258357e2da240aa62b6725ec7920f332673df7e2"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/spf13/hugo.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "966dc08030283e2d7582f49ec7b326a0f1f17b75ee91068de913f961e21233c9" => :sierra
    sha256 "4ee849bd7db2471d6c3c140ff2bfa9f262160f3d0aadbe400193341eacd7a73e" => :el_capitan
    sha256 "3c993a3f0dd28ce2e15bd4428e548a8b0a2e0494dc26bb9441d0ae7cd3c601ab" => :yosemite
=======
    sha256 "58f7db1d5812f041f39f60150a3ed332e63b65769a5e9cf2cde51d1d497ba1b7" => :sierra
    sha256 "de0f797ae8443036c042032e5bee4c9e4145622cd69e9334ba0213758a1314a4" => :el_capitan
    sha256 "69e2262db2b669294d2b65686ab6627b396d2fc834e1042a3afde131c086b86c" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "go" => :build
  depends_on "govendor" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/spf13/hugo").install buildpath.children
    cd "src/github.com/spf13/hugo" do
      system "govendor", "sync"
      system "go", "build", "-o", bin/"hugo", "main.go"

      # Build bash completion
      system bin/"hugo", "gen", "autocomplete", "--completionfile=hugo.sh"
      bash_completion.install "hugo.sh"

      # Build man pages; target dir man/ is hardcoded :(
      (Pathname.pwd/"man").mkpath
      system bin/"hugo", "gen", "man"
      man1.install Dir["man/*.1"]

      prefix.install_metafiles
    end
  end

  test do
    site = testpath/"hops-yeast-malt-water"
    system "#{bin}/hugo", "new", "site", site
    assert File.exist?("#{site}/config.toml")
  end
end
