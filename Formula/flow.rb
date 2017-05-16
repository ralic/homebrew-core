class Flow < Formula
  desc "Static type checker for JavaScript"
  homepage "https://flowtype.org/"
<<<<<<< HEAD
  head "https://github.com/facebook/flow.git"

  stable do
    url "https://github.com/facebook/flow/archive/v0.45.0.tar.gz"
    sha256 "9a76cb1669d5d1f07a55b3163edb0329c46565033eaf7ed9320058b6e3a9cbbf"

    # Remove for > 0.45.0
    # Upstream commit from 28 Apr 2017 "Add `make all-homebrew`"
    patch do
      url "https://github.com/facebook/flow/commit/8a811a4b443ec545d89aa201d5ebcc254ae220e4.patch"
      sha256 "f92aca59e2014b91974c02672e0d55b3b278d3a267150cfb534d266befda4ad4"
    end

    # Remove for > 0.45.0
    # Upstream commit from 28 Apr 2017 "mktemp's interface changed in OSX 10.11"
    patch do
      url "https://github.com/facebook/flow/commit/7cc0f0b3f34e6932e7a713de2a651a1848eef395.patch"
      sha256 "d7eac833d7ee1dd7ee6ec47dfdc4f68e9b31555d3d39670d675ec81ec8a5127d"
    end
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "d18214fdc02524e872422e38391f67eca3923a5ae8c92ca7b19e053aaa853128" => :sierra
    sha256 "ed10e631f87e8316d3473719fd15761da02e79993cd04617545226acbdd6a899" => :el_capitan
    sha256 "9add8e39f9ee1c20e904043a64ca9b2dc62e0b907be3bb8a3055f3321b3b810f" => :yosemite
=======
  url "https://github.com/facebook/flow/archive/v0.46.0.tar.gz"
  sha256 "f6991604d95285c0944cab4b1b075facae53a4dd59bd836ee24cacd7f85b42a7"
  head "https://github.com/facebook/flow.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "8fdb2ad50afc0a82e5e8c14e099cfe67234e53773d7c08b0ce203518afae44ab" => :sierra
    sha256 "956e2e02b583fd4f92c0486752afca5012dc67b0b73edd9b580ecfd4746c889b" => :el_capitan
    sha256 "e751f655a7f23d7cfefe7a4421e6da008db8398661ba398916cfc405ff68eb4f" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "ocaml" => :build
  depends_on "opam" => :build

  def install
    system "make", "all-homebrew"

    bin.install "bin/flow"

    bash_completion.install "resources/shell/bash-completion" => "flow-completion.bash"
    zsh_completion.install_symlink bash_completion/"flow-completion.bash" => "_flow"
  end

  test do
    system "#{bin}/flow", "init", testpath
    (testpath/"test.js").write <<-EOS.undent
      /* @flow */
      var x: string = 123;
    EOS
    expected = /Found 1 error/
    assert_match expected, shell_output("#{bin}/flow check #{testpath}", 2)
  end
end
