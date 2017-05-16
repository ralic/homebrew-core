class ZshCompletions < Formula
  desc "Additional completion definitions for zsh"
  homepage "https://github.com/zsh-users/zsh-completions"
<<<<<<< HEAD
  url "https://github.com/zsh-users/zsh-completions/archive/0.24.0.tar.gz"
  sha256 "124e585332dc35830a9169ab27710def24618e0083e1ccc18c6a0664e2f3406e"
=======
  url "https://github.com/zsh-users/zsh-completions/archive/0.25.0.tar.gz"
  sha256 "6a89fb148313577ea81a36630bc2bf009aaaf74a116109cb33f422396e23ab0f"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.

  head "https://github.com/zsh-users/zsh-completions.git"

  bottle :unneeded

  def install
    pkgshare.install Dir["src/_*"]
  end

  def caveats
    <<-EOS.undent
    To activate these completions, add the following to your .zshrc:

      fpath=(#{HOMEBREW_PREFIX}/share/zsh-completions $fpath)

    You may also need to force rebuild `zcompdump`:

      rm -f ~/.zcompdump; compinit

    Additionally, if you receive "zsh compinit: insecure directories" warnings when attempting
    to load these completions, you may need to run this:

      chmod go-w '#{HOMEBREW_PREFIX}/share'
    EOS
  end

  test do
<<<<<<< HEAD
    (testpath/".zshrc").write <<-EOS.undent
      fpath=(#{HOMEBREW_PREFIX}/share/zsh-completions $fpath)
      autoload -U compinit
      compinit
    EOS
    system "/bin/zsh", "--login", "-i", "-c", "which _ack"
=======
    (testpath/"test.zsh").write <<-EOS.undent
      fpath=(#{pkgshare} $fpath)
      autoload _ack
      which _ack
    EOS
    assert_match /^_ack/, shell_output("/bin/zsh test.zsh")
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end
end
