require "language/haskell"

class GitAnnex < Formula
  include Language::Haskell::Cabal

  desc "Manage files with git without checking in file contents"
  homepage "https://git-annex.branchable.com/"
<<<<<<< HEAD
  url "https://hackage.haskell.org/package/git-annex-6.20170321/git-annex-6.20170321.tar.gz"
  sha256 "f86351a99bbfff0285914c4639d2bc68ffcc172a6dacdef164254261cf1f0795"
  head "git://git-annex.branchable.com/"

  bottle do
    sha256 "e5fd0dabbcb81a58bc096525cf0894ddffa1aa94c6cae2e375e9b4d8fa7287fc" => :sierra
    sha256 "512d68a9e961edd276b9931f2527e310e215bf6fcc322091d7f6e377d0b47625" => :el_capitan
    sha256 "8383586c06e77e8492e5d3348aad5e30530d216f251127f10f5e7d5787833ffd" => :yosemite
=======
  url "https://hackage.haskell.org/package/git-annex-6.20170510/git-annex-6.20170510.tar.gz"
  sha256 "f85f4e0fb737daeb38bdd420daabaff7862e16bdf4e237d93be28649b7d00512"
  head "git://git-annex.branchable.com/"

  bottle do
    sha256 "2a870842ab8c41f41e72f0eca4df8b784d0c6d7e39357db537006e6ed91d1e73" => :sierra
    sha256 "abc1ba1636e364ccd16e09c49429240fcc590018795226e4107dd6314525b3cd" => :el_capitan
    sha256 "ffb5fb90c1e8b4aa8c8c01d22f4d50bb88d4d64faf588f684582bcc92be82dc5" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  option "with-git-union-merge", "Build the git-union-merge tool"

  depends_on "ghc" => :build
  depends_on "cabal-install" => :build
  depends_on "pkg-config" => :build
  depends_on "gsasl"
<<<<<<< HEAD
  depends_on "libidn"
  depends_on "libmagic"
  depends_on "gnutls"
=======
  depends_on "libmagic"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  depends_on "quvi"
  depends_on "xdot" => :recommended

  def install
    install_cabal_package :using => ["alex", "happy", "c2hs"], :flags => ["s3", "webapp"] do
      # this can be made the default behavior again once git-union-merge builds properly when bottling
      if build.with? "git-union-merge"
        system "make", "git-union-merge", "PREFIX=#{prefix}"
        bin.install "git-union-merge"
        system "make", "git-union-merge.1", "PREFIX=#{prefix}"
      end
    end
    bin.install_symlink "git-annex" => "git-annex-shell"
  end

  test do
    # make sure git can find git-annex
    ENV.prepend_path "PATH", bin
    # We don't want this here or it gets "caught" by git-annex.
    rm_r "Library/Python/2.7/lib/python/site-packages/homebrew.pth"

    system "git", "init"
    system "git", "annex", "init"
    (testpath/"Hello.txt").write "Hello!"
    assert !File.symlink?("Hello.txt")
    assert_match "add Hello.txt ok", shell_output("git annex add .")
    system "git", "commit", "-a", "-m", "Initial Commit"
    assert File.symlink?("Hello.txt")

    # The steps below are necessary to ensure the directory cleanly deletes.
    # git-annex guards files in a way that isn't entirely friendly of automatically
    # wiping temporary directories in the way `brew test` does at end of execution.
    system "git", "rm", "Hello.txt", "-f"
    system "git", "commit", "-a", "-m", "Farewell!"
    system "git", "annex", "unused"
    assert_match "dropunused 1 ok", shell_output("git annex dropunused 1 --force")
    system "git", "annex", "uninit"
  end
end
