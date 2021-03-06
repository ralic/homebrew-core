class KubernetesHelm < Formula
  desc "The Kubernetes package manager"
  homepage "https://helm.sh/"
  url "https://github.com/kubernetes/helm.git",
<<<<<<< HEAD
      :tag => "v2.3.1",
      :revision => "32562a3040bb5ca690339b9840b6f60f8ce25da4"
=======
      :tag => "v2.4.1",
      :revision => "46d9ea82e2c925186e1fc620a8320ce1314cbb02"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/kubernetes/helm.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "76bbd83bd12ef47901814c4b48682416a18559b868839453d1c2d26c21a0f89f" => :sierra
    sha256 "a64f6d4145fc0dbbfe32f219397e0c979d24aea68ce99c33459a62e6bed86846" => :el_capitan
    sha256 "5be9c707046fc54d8aa291708d169b8633128360fd7c3e35cc5ae614cc8ebe76" => :yosemite
=======
    sha256 "e298182f462c4866cd7215a1638f322edadd1ca91f365818e1de158aeca2cbed" => :sierra
    sha256 "87934017fb0b2678942d2e2781c8f180d8fd446ae43346a78c576fd46799997e" => :el_capitan
    sha256 "f961b4784d750470d66a0599935d6a2412fc203243a7d62a4607f56496fcb0b1" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on :hg => :build
  depends_on "go" => :build
  depends_on "glide" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GLIDE_HOME"] = HOMEBREW_CACHE/"glide_home/#{name}"
    ENV.prepend_create_path "PATH", buildpath/"bin"
    arch = MacOS.prefer_64_bit? ? "amd64" : "x86"
    ENV["TARGETS"] = "darwin/#{arch}"
    dir = buildpath/"src/k8s.io/helm"
    dir.install buildpath.children - [buildpath/".brew_home"]

    cd dir do
      # Bootstap build
      system "make", "bootstrap"

      # Make binary
      system "make", "build"
      bin.install "bin/helm"
<<<<<<< HEAD
=======
      bin.install "bin/tiller"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.

      # Install man pages
      man1.install Dir["docs/man/man1/*"]

      # Install bash completion
      bash_completion.install "scripts/completions.bash" => "helm"
    end
  end

  test do
    system "#{bin}/helm", "create", "foo"
    assert File.directory? "#{testpath}/foo/charts"

    version_output = shell_output("#{bin}/helm version --client 2>&1")
    assert_match "GitTreeState:\"clean\"", version_output
    assert_match stable.instance_variable_get(:@resource).instance_variable_get(:@specs)[:revision], version_output if build.stable?
  end
end
