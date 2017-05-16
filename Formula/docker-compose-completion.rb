class DockerComposeCompletion < Formula
  desc "docker-compose completion script"
  homepage "https://docs.docker.com/compose/completion/"
<<<<<<< HEAD
  url "https://github.com/docker/compose/archive/1.12.0.tar.gz"
  sha256 "7a51cf38feb6d62e63e124bd6ea5d0de3527a01b997a609ba8b516a829e39b33"
=======
  url "https://github.com/docker/compose/archive/1.13.0.tar.gz"
  sha256 "0cace4a814cf629689f1738fc221eb0de12f6336ee682b8c9539568f63cf6785"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/docker/compose.git"

  bottle :unneeded

  conflicts_with "docker-compose",
    :because => "docker-compose already includes completion scripts"

  def install
    bash_completion.install "contrib/completion/bash/docker-compose"
    zsh_completion.install "contrib/completion/zsh/_docker-compose"
  end

  test do
    assert_match "-F _docker_compose",
      shell_output("bash -c 'source #{bash_completion}/docker-compose && complete -p docker-compose'")
  end
end
