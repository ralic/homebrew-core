class Bitrise < Formula
  desc "Command-line automation tool"
  homepage "https://github.com/bitrise-io/bitrise"
<<<<<<< HEAD
  url "https://github.com/bitrise-io/bitrise/archive/1.5.6.tar.gz"
  sha256 "3ff3cfff1b9553c0bf92c6e9e757634bc3894c9c8a6dfa4b2d8fd29445376448"

  bottle do
    cellar :any_skip_relocation
    sha256 "8cc3421639fc463156c27ea9736719a8e1f3e7954da70a0868afbe3d9b43673c" => :sierra
    sha256 "5739b4ce9e5a60fba05baaa057bb2d0ccca51765666421c6b7b004ba23e98fd1" => :el_capitan
    sha256 "d4daccddcc4602b34bb31d4489c96132826d598a7d86f6525303bc9b01024da0" => :yosemite
=======
  url "https://github.com/bitrise-io/bitrise/archive/1.6.1.tar.gz"
  sha256 "e35b553d194f98514432611d8b083ba43cb7df567811298edd7b7fe24d3e5397"

  bottle do
    cellar :any_skip_relocation
    sha256 "920bbb808265501593500f427f1da11a49635ab6a26b9d42cfe5397b2cec5079" => :sierra
    sha256 "1a2bbf15017f9f25da3d95779459e25c0c172b1b5dc8a3611217370def562129" => :el_capitan
    sha256 "ccb0e4047de9f8b92b31166a54cc353635f2356b81232028bb2bab177b09c7df" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath

    # Install bitrise
    bitrise_go_path = buildpath/"src/github.com/bitrise-io/bitrise"
    bitrise_go_path.install Dir["*"]

    cd bitrise_go_path do
      prefix.install_metafiles

      system "go", "build", "-o", bin/"bitrise"
    end
  end

  test do
    (testpath/"bitrise.yml").write <<-EOS.undent
      format_version: 1.3.1
      default_step_lib_source: https://github.com/bitrise-io/bitrise-steplib.git
      workflows:
        test_wf:
          steps:
          - script:
              inputs:
              - content: printf 'Test - OK' > brew.test.file
    EOS

    system "#{bin}/bitrise", "setup"
    system "#{bin}/bitrise", "run", "test_wf"
    assert_equal "Test - OK", (testpath/"brew.test.file").read.chomp
  end
end
