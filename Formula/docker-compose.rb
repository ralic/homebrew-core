class DockerCompose < Formula
  include Language::Python::Virtualenv

  desc "Isolated development environments using Docker"
  homepage "https://docs.docker.com/compose/"
<<<<<<< HEAD
  url "https://github.com/docker/compose/archive/1.12.0.tar.gz"
  sha256 "7a51cf38feb6d62e63e124bd6ea5d0de3527a01b997a609ba8b516a829e39b33"
=======
  url "https://github.com/docker/compose/archive/1.13.0.tar.gz"
  sha256 "0cace4a814cf629689f1738fc221eb0de12f6336ee682b8c9539568f63cf6785"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/docker/compose.git"

  bottle do
    cellar :any
<<<<<<< HEAD
    sha256 "a2b574e654393ce7590dc987f03b862d53da271413453187e5d759938e37e9d8" => :sierra
    sha256 "c206f3582891337e09e855a6f460e96e6373ba5d7a4b0cb2adf3964037f23d4c" => :el_capitan
    sha256 "9aed20bef54a106586a7b28c90b71d946adc2f7779ce01b5c407b92692290613" => :yosemite
=======
    sha256 "5b8ba04a5ee2dc837a60c2d366331de9545488dc4df9f631d1cdc62192be1e48" => :sierra
    sha256 "8596d2a1299f63d51dd55019f86725117847ddc27cb7e3ad6313f03ede2f8870" => :el_capitan
    sha256 "7d6f664b52e9f698173f9ddcb03b0af31eb5c24f35a20a4b7fec69be2e1a934f" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on :python if MacOS.version <= :snow_leopard
  depends_on "libyaml"

  # It's possible that the user wants to manually install Docker and Machine,
  # for example, they want to compile Docker manually
  depends_on "docker" => :recommended
  depends_on "docker-machine" => :recommended

  def install
    system "./script/build/write-git-sha" if build.head?
    venv = virtualenv_create(libexec)
    system libexec/"bin/pip", "install", "-v", "--no-binary", ":all:",
                              "--ignore-installed", buildpath
    system libexec/"bin/pip", "uninstall", "-y", "docker-compose"
    venv.pip_install_and_link buildpath

    bash_completion.install "contrib/completion/bash/docker-compose"
    zsh_completion.install "contrib/completion/zsh/_docker-compose"
  end

  test do
    system bin/"docker-compose", "--help"
  end
end
