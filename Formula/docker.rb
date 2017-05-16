class Docker < Formula
  desc "Pack, ship and run any application as a lightweight container"
  homepage "https://www.docker.com/"
  url "https://github.com/docker/docker.git",
<<<<<<< HEAD
      :tag => "v17.04.0-ce",
      :revision => "4845c567eb35d68f35b0b1713a09b0c8d47fe67e"
=======
      :tag => "v17.05.0-ce",
      :revision => "89658bed64c2a8fe05a978e5b87dbec409d57a0f"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.

  head "https://github.com/docker/docker.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "d2c909a58ac30a2d7c5c89127f3e9dcfbe4b6730ece34e68176a7f272e455c28" => :sierra
    sha256 "3e5ee5765c066fbbefe9aec04965eaaa0d199d46b7f5ffb7a6a5ce5c60b75b17" => :el_capitan
    sha256 "f857c190f4cc805a207d39fc1d7f3c020d93438aedda32cf1d876dceb236c40b" => :yosemite
=======
    sha256 "d60ad4d00efd0d0358a93fe19d91ce155a37a184e4a98b29e74a215d17497b26" => :sierra
    sha256 "7faaea79928b474f1f01fcca3864fa1effe49c9f3519279555f88e97310d5852" => :el_capitan
    sha256 "7f9827b8ff928e62e49a76a1d2a3d35a3c5b2b2319db9d83f560742415700dd4" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  option "with-experimental", "Enable experimental features"
  option "without-completions", "Disable bash/zsh completions"

  depends_on "go" => :build

  if build.with? "experimental"
    depends_on "libtool" => :run
    depends_on "yubico-piv-tool" => :recommended
  end

  def install
    ENV["AUTO_GOPATH"] = "1"
    ENV["DOCKER_EXPERIMENTAL"] = "1" if build.with? "experimental"

    system "hack/make.sh", "dynbinary-client"

    build_version = build.head? ? File.read("VERSION").chomp : "#{version}-ce"
    bin.install "bundles/#{build_version}/dynbinary-client/docker-#{build_version}" => "docker"

    if build.with? "completions"
      bash_completion.install "contrib/completion/bash/docker"
      fish_completion.install "contrib/completion/fish/docker.fish"
      zsh_completion.install "contrib/completion/zsh/_docker"
    end
  end

  test do
    system "#{bin}/docker", "--version"
  end
end
