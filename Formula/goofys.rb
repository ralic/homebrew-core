require "language/go"

class Goofys < Formula
  desc "Filey-System interface to Amazon S3"
  homepage "https://github.com/kahing/goofys"
  url "https://github.com/kahing/goofys.git",
<<<<<<< HEAD
      :tag => "v0.0.9",
      :revision => "f8d668c29bbf43aa36acea68e05b493f16f5e990"
=======
      :tag => "v0.0.10",
      :revision => "6b1426ffa4010f35997d943de13c7dd2d03cf217"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.

  head "https://github.com/kahing/goofys.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "214c728ceb4cac8d251dbc45630093d00db03a2bf43d9d6cab5d5ed0bd880d64" => :sierra
    sha256 "f2a85e78185766488a036cb6fd2bf1a5523ad5d9acb3f5e6b1b6c9d78a8ead80" => :el_capitan
    sha256 "198a37cf47fe63c25f72ce0aa490fbc2efa4ffc0d9f0195d5334524ce2a26ff6" => :yosemite
=======
    sha256 "ddafa269456b20fa12bab697cb54dab3590e8c37668e96d26dacffbd0f5d98c3" => :sierra
    sha256 "5be7566385a86b295d121e721e3f2e6e9629d44e4a404f3a968dbe46553ee59f" => :el_capitan
    sha256 "6680d49d0784ecba64ab26daf251651cc8548611bdbeedd6bd5b80e9cf82cd56" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "go" => :build
  depends_on :osxfuse

  go_resource "github.com/Sirupsen/logrus" do
    url "https://github.com/Sirupsen/logrus.git",
<<<<<<< HEAD
        :revision => "881bee4e20a5d11a6a88a5667c6f292072ac1963"
=======
        :revision => "10f801ebc38b33738c9d17d50860f484a0988ff5"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  go_resource "github.com/codegangsta/cli" do
    url "https://github.com/codegangsta/cli.git",
<<<<<<< HEAD
        :revision => "0bdeddeeb0f650497d603c4ad7b20cfe685682f6"
=======
        :revision => "ab403a54a148f2d857920810291539e1f817ee7b"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  go_resource "github.com/jacobsa/fuse" do
    url "https://github.com/jacobsa/fuse.git",
<<<<<<< HEAD
        :revision => "2642d571aa800c9ddca51e63800a57046970ce96"
=======
        :revision => "dc1be2d5b8abc34991a649f7499f9f673e36bb46"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  go_resource "github.com/kardianos/osext" do
    url "https://github.com/kardianos/osext.git",
<<<<<<< HEAD
        :revision => "c2c54e542fb797ad986b31721e1baedf214ca413"
=======
        :revision => "9d302b58e975387d0b4d9be876622c86cefe64be"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  go_resource "github.com/sevlyar/go-daemon" do
    url "https://github.com/sevlyar/go-daemon.git",
        :revision => "8577c7ddef908e104dae56c9e46f0956cb33c844"
  end

  go_resource "github.com/shirou/gopsutil" do
    url "https://github.com/shirou/gopsutil.git",
<<<<<<< HEAD
        :revision => "93564b314264efac01934715fad4c355ed6af1c5"
=======
        :revision => "119305b4ceb81cc9314ee187970584a0923b0679"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  go_resource "golang.org/x/net" do
    url "https://github.com/golang/net.git",
<<<<<<< HEAD
        :revision => "8fd7f25955530b92e73e9e1932a41b522b22ccd9"
=======
        :revision => "0819898fb4973868bba6de59b6aaad75beea9a6a"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  def install
    contents = Dir["*"]
    gopath = buildpath/"gopath"
    (gopath/"src/github.com/kahing/goofys").install contents

    ENV["GOPATH"] = gopath

    Language::Go.stage_deps resources, gopath/"src"

    cd gopath/"src/github.com/kahing/goofys" do
      system "go", "build", "-o", "goofys"
      bin.install "goofys"
    end
  end

  test do
    system "#{bin}/goofys", "--version"
  end
end
