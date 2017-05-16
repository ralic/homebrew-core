class GitRemoteHg < Formula
<<<<<<< HEAD
=======
  include Language::Python::Virtualenv

>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  desc "Transparent bidirectional bridge between Git and Mercurial"
  homepage "https://github.com/felipec/git-remote-hg"
  url "https://github.com/felipec/git-remote-hg/archive/v0.3.tar.gz"
  sha256 "2dc889b641d72f5a73c4c7d5df3b8ea788e75a7ce80f5884a7a8d2e099287dce"
  head "https://github.com/felipec/git-remote-hg.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "d9e8ae77b5ce8908031ddf5f4a1e166226ad2cc6664a98ab9edcb8c44b82c270" => :sierra
    sha256 "0e85f91992caf6662783a2e53ffd4fbbb04c0600b702bb27f8ebe1a8b51bb683" => :el_capitan
    sha256 "ffd2c6e7361d41e20209cf738b97292fda480ef78ab5264967be08ecb8103b7a" => :yosemite
    sha256 "808c74fd0e1d5d5deb32e768f86393695075fa82359fd2b186604296606846da" => :mavericks
=======
    rebuild 1
    sha256 "f0b8d090aaf5e8aa4b63418efcc8a0e6fc1fe7cafc39bee6a8bc85abd8c106db" => :sierra
    sha256 "6af3e5642dbe91d832b035baf74d199cbda4af7bdb39b0a0d09d336098fa4693" => :el_capitan
    sha256 "45529e66698b9505e61c718d43f46c99dc31ef2b37802939e17d391ede5ae912" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on :hg
  depends_on :python if MacOS.version <= :snow_leopard

<<<<<<< HEAD
  def install
    inreplace "git-remote-hg", "python2", "python"
=======
  resource "hg" do
    url "https://mercurial-scm.org/release/mercurial-4.1.3.tar.gz"
    sha256 "103d2ae187d5c94110c0e86ccc3b46f55fcd8e21c78d1c209bac7b59a73e86d8"
  end

  def install
    venv = virtualenv_create(libexec)
    venv.pip_install resource("hg")
    inreplace "git-remote-hg", /#!.*/, "#!#{libexec}/bin/python"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    system "git", "clone", "hg::https://www.mercurial-scm.org/repo/hello"
  end
end
