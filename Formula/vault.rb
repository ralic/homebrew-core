require "language/go"

# Please don't update this formula until the release is official via
# mailing list or blog post. There's a history of GitHub tags moving around.
# https://github.com/hashicorp/vault/issues/1051
class Vault < Formula
  desc "Secures, stores, and tightly controls access to secrets"
  homepage "https://vaultproject.io/"
  url "https://github.com/hashicorp/vault.git",
<<<<<<< HEAD
      :tag => "v0.7.0",
      :revision => "614deacfca3f3b7162bbf30a36d6fc7362cd47f0"
=======
      :tag => "v0.7.2",
      :revision => "d28dd5a018294562dbc9a18c95554d52b5d12390"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/hashicorp/vault.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "334905a9eaf657649c8df1282fb56239c75eb2afc2acfc4b6d2fa5004253edb1" => :sierra
    sha256 "6fe1bf96e2e9e508b66f4e2af6569c53bac78555aa0df5476dbf057d1dde85c3" => :el_capitan
    sha256 "ed6cb308d84c472d08a249ea051655ee8466f57658151e70c5870142697df6fb" => :yosemite
=======
    sha256 "0e14f1e8342b144f154a62274b424b50d44eabeda1aa348563c34fb0a930d52c" => :sierra
    sha256 "44657829481a071a9d52f52f70b68c222c906fc1b18a835f23e2e37d36bae9db" => :el_capitan
    sha256 "993b4a4a8105a707ea1cfc7f32eaa5c5c32fed290d4dbbaa8bff61e5aa14810a" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  option "with-dynamic", "Build dynamic binary with CGO_ENABLED=1"

  depends_on "go" => :build

  go_resource "github.com/mitchellh/iochan" do
    url "https://github.com/mitchellh/iochan.git",
        :revision => "87b45ffd0e9581375c491fef3d32130bb15c5bd7"
  end

  go_resource "github.com/mitchellh/gox" do
    url "https://github.com/mitchellh/gox.git",
        :revision => "c9740af9c6574448fd48eb30a71f964014c7a837"
  end

  def install
    ENV["GOPATH"] = buildpath

    contents = buildpath.children - [buildpath/".brew_home"]
    (buildpath/"src/github.com/hashicorp/vault").install contents

    ENV.prepend_create_path "PATH", buildpath/"bin"

    Language::Go.stage_deps resources, buildpath/"src"

    cd "src/github.com/mitchellh/gox" do
      system "go", "install"
    end

    cd "src/github.com/hashicorp/vault" do
      target = build.with?("dynamic") ? "dev-dynamic" : "dev"
      system "make", target
      bin.install "bin/vault"
      prefix.install_metafiles
    end
  end

  test do
    pid = fork { exec bin/"vault", "server", "-dev" }
    sleep 1
    ENV.append "VAULT_ADDR", "http://127.0.0.1:8200"
    system bin/"vault", "status"
    Process.kill("TERM", pid)
  end
end
