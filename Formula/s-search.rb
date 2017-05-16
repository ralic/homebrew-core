require "language/go"

class SSearch < Formula
  desc "Web search from the terminal"
  homepage "https://github.com/zquestz/s"
<<<<<<< HEAD
  url "https://github.com/zquestz/s/archive/v0.5.9.tar.gz"
  sha256 "7dba775f7fdf6c8dc28ace8795e8f57c0b7dd6148f14fe4b17c5a4eb46b675ec"
=======
  url "https://github.com/zquestz/s/archive/v0.5.10.tar.gz"
  sha256 "8a5ba823d02f495dd1bb150882ddccd2bb082efff4c996b9b43e4cd5599d3df2"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/zquestz/s.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "f56664578fff8503c568e1b638c336726ecf8d9b03797011e057afdc0e48ec22" => :sierra
    sha256 "dbf57d132010f1e1b6d2d17227ff86d0822f050be0b88c1f7e58a932c7d6024f" => :el_capitan
    sha256 "2cb23811b41c65b20b0ea3d4c061491ad58d10265c9840eb8fbded46a4cc1eac" => :yosemite
=======
    sha256 "4c4e0898c7d72d5bcf384065b29dc2a724e543462647dca2eddd85d4a2b84ae0" => :sierra
    sha256 "10b84b6a4b0a9438d2cd552ecda4ea33f49c4d5a13231523b1ad4dfb37bc8c84" => :el_capitan
    sha256 "af20fd23c49ce40ef2954d22ac6ee72b308730cbfebd1d8c9bc46b9dbc99219f" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "go" => :build

  go_resource "github.com/FiloSottile/gvt" do
    url "https://github.com/FiloSottile/gvt.git",
<<<<<<< HEAD
        :revision => "1f87bb350317842680fd7e0fdec64b4e14c79576"
=======
        :revision => "50d83ea21cb0405e81efd284951e111b3a68d701"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  def install
    ENV["GOPATH"] = buildpath
    Language::Go.stage_deps resources, buildpath/"src"
    cd("src/github.com/FiloSottile/gvt") { system "go", "install" }
    (buildpath/"src/github.com/zquestz").mkpath
    ln_s buildpath, "src/github.com/zquestz/s"
    system buildpath/"bin/gvt", "restore"
    system "go", "build", "-o", bin/"s"
  end

  test do
    output = shell_output("#{bin}/s -p bing -b echo homebrew")
    assert_equal "https://www.bing.com/search?q=homebrew", output.chomp
  end
end
