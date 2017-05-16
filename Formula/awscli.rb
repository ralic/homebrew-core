class Awscli < Formula
  include Language::Python::Virtualenv

  desc "Official Amazon AWS command-line interface"
  homepage "https://aws.amazon.com/cli/"
<<<<<<< HEAD
  url "https://github.com/aws/aws-cli/archive/1.11.82.tar.gz"
  sha256 "3bbe10afb4dd23feb6f823d7dca1dadcbfa41a0d53b50041e550416ba58812c6"
=======
  url "https://github.com/aws/aws-cli/archive/1.11.85.tar.gz"
  sha256 "48b461850fa53592767602950be506bf97ebcdbcdb16e3cc14f4b8f6593edb8d"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/aws/aws-cli.git", :branch => "develop"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "d893531c718e926ecebc3f089efb6be23f96e3701202866e205a3c148a765f15" => :sierra
    sha256 "7447a0d701b67dab2a32512f025f3b8767484cfa7cec2511198cfdc1b84f1fc5" => :el_capitan
    sha256 "c8201bc05004ea9ada23dceb276af2171c4b1f4a4bcb1153d5bdd55acd9a60f2" => :yosemite
=======
    sha256 "5800022cd834d6921f3490bf1f6e8551a2f1e27def7d3027d2b1eb639c72565d" => :sierra
    sha256 "21f05fa7c28a21e13908ff2cd308b8632748fc6c3d5c9753f620dc34d4eedc3b" => :el_capitan
    sha256 "9be59bff2bed77a37feaf7b686772f5c360acdeb74da0ec4fc1d0fa1e3549c13" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  # Use :python on Lion to avoid urllib3 warning
  # https://github.com/Homebrew/homebrew/pull/37240
  depends_on :python if MacOS.version <= :lion

  def install
    venv = virtualenv_create(libexec)
    system libexec/"bin/pip", "install", "-v", "--no-binary", ":all:",
                              "--ignore-installed", buildpath
    system libexec/"bin/pip", "uninstall", "-y", "awscli"
    venv.pip_install_and_link buildpath
    pkgshare.install "awscli/examples"

    bash_completion.install "bin/aws_bash_completer"
    zsh_completion.install "bin/aws_zsh_completer.sh" => "_aws"
  end

  def caveats; <<-EOS.undent
    The "examples" directory has been installed to:
      #{HOMEBREW_PREFIX}/share/awscli/examples
    EOS
  end

  test do
    assert_match "topics", shell_output("#{bin}/aws help")
  end
end
