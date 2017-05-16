class Teleport < Formula
  desc "Modern SSH server for teams managing distributed infrastructure"
  homepage "https://gravitational.com/teleport"
<<<<<<< HEAD
  url "https://github.com/gravitational/teleport/archive/v2.0.4.tar.gz"
  sha256 "eed81794ca0cc0a4bf18c4295c7de3f1bd35f26a984dbc6cba41391e786a6df8"

  bottle do
    sha256 "ab95c5ebbe74e556d9ebfd5aa7c5f4562c0b65f3167e93b0e583d8d639620924" => :sierra
    sha256 "0f5f797f466cdef0729a8b910fd8469f56e63af0f24b317fdbaeef873314537d" => :el_capitan
    sha256 "988cea7f43c6f5fbbdef39b69af92d823ead3a1af2230041ef6033e0b511405d" => :yosemite
=======
  url "https://github.com/gravitational/teleport/archive/v2.0.6.tar.gz"
  sha256 "f58090bcab326ff6a7b7902d01203f605b0a241992dd9ba908678e9f6132b16f"

  bottle do
    sha256 "4631123bb62d69002e9b2a6ddce4b42b737941ce85456cf57f1d0f9f4a3d2889" => :sierra
    sha256 "9645b557e0e63c8380f0242fc131ba5aefc31f02982f609affd165874daf41f0" => :el_capitan
    sha256 "49b619b2dde59bf32eb20a3e23b70b1cfffadce2b91b12800725595fc55c9895" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "go" => :build

  def install
    ENV["GOOS"] = "darwin"
    ENV["GOARCH"] = MacOS.prefer_64_bit? ? "amd64" : "386"
    ENV["GOPATH"] = buildpath
    ENV["GOROOT"] = Formula["go"].opt_libexec

    (buildpath / "src/github.com/gravitational/teleport").install buildpath.children
    ln_s buildpath/"src", buildpath / "src/github.com/gravitational/teleport"

    cd "src/github.com/gravitational/teleport" do
      ENV.deparallelize { system "make", "release" }
      system "/usr/bin/tar", "-xvf", "teleport-v#{version}-#{ENV["GOOS"]}-#{ENV["GOARCH"]}-bin.tar.gz"
      cd "teleport" do
        bin.install %w[teleport tctl tsh]
        prefix.install_metafiles
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/teleport version")
    assert_match version.to_s, shell_output("#{bin}/tctl version")
    assert_match version.to_s, shell_output("#{bin}/tsh version")
    (testpath/"config.yml").write shell_output("#{bin}/teleport configure")
      .gsub("0.0.0.0", "127.0.0.1")
      .gsub("/var/lib/teleport", testpath)
      .gsub("/var/run", testpath)
      .gsub(/https_(.*)/, "")
    begin
      pid = spawn("#{bin}/teleport start -c #{testpath}/config.yml")
      sleep 5
      system "/usr/bin/curl", "--insecure", "https://localhost:3080"
      system "/usr/bin/nc", "-z", "localhost", "3022"
      system "/usr/bin/nc", "-z", "localhost", "3023"
      system "/usr/bin/nc", "-z", "localhost", "3025"
    ensure
      Process.kill(9, pid)
    end
  end
end
