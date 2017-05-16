class Scw < Formula
<<<<<<< HEAD
  desc "Manage BareMetal Servers from Command Line (as easily as with Docker)"
  homepage "https://github.com/scaleway/scaleway-cli"
  url "https://github.com/scaleway/scaleway-cli/archive/v1.12.tar.gz"
  sha256 "7a23ef6960fe280dd19f8e2e9b0fff6ffaf4b8446ddc7833b530901875652e2e"
=======
  desc "Manage BareMetal Servers from command-line (as easily as with Docker)"
  homepage "https://github.com/scaleway/scaleway-cli"
  url "https://github.com/scaleway/scaleway-cli/archive/v1.13.tar.gz"
  sha256 "0be6076af3d41f94f27138415da394fb5424a654214edab58b9bdb1c9fd8a2cb"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/scaleway/scaleway-cli.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "80a12f0378bf0cc4d6821b9dd9c3381b89771e95f523d57d876b7d7e316affa1" => :sierra
    sha256 "792be6c0a7b700ad9ae6c618dde4e6e9fbf7a35e1c204ebf4d366c805d191cec" => :el_capitan
    sha256 "d5d5189fd3a4e2fcf368717e770a811f5a7c4558022b450fa330503b106d1c7e" => :yosemite
=======
    sha256 "4fa18d6dabc15431d158298e6a6ac27bfe3bd9bc99de97b9b685518ccf92ab00" => :sierra
    sha256 "3fc45c7cd3909bcc34541ce9dd5306bdc057a2f7fdd6cb96d47f91752d095343" => :el_capitan
    sha256 "9cde79706ea4556994a01f8e726615319ea309ee6be197228169a9201254f74b" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOBIN"] = buildpath
    (buildpath/"src/github.com/scaleway/scaleway-cli").install Dir["*"]

    system "go", "build", "-o", "#{bin}/scw", "-v", "-ldflags", "-X  github.com/scaleway/scaleway-cli/pkg/scwversion.GITCOMMIT=homebrew", "github.com/scaleway/scaleway-cli/cmd/scw/"

    bash_completion.install "src/github.com/scaleway/scaleway-cli/contrib/completion/bash/scw"
    zsh_completion.install "src/github.com/scaleway/scaleway-cli/contrib/completion/zsh/_scw"
  end

  test do
    output = shell_output(bin/"scw version")
    assert_match "OS/Arch (client): darwin/amd64", output
  end
end
