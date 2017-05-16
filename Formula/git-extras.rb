class GitExtras < Formula
  desc "Small git utilities"
  homepage "https://github.com/tj/git-extras"
  head "https://github.com/tj/git-extras.git"

  stable do
<<<<<<< HEAD
    url "https://github.com/tj/git-extras/archive/4.2.0.tar.gz"
    sha256 "53668af26c58e7866addbd2b14b29f63ee39029bdcee5f48957c4a958bdb225f"
=======
    url "https://github.com/tj/git-extras/archive/4.3.0.tar.gz"
    sha256 "25e608ba17b49d38e1f1f9938cceb9a7406f4e2a5e9488898c193e82ac42e3be"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
    # Disable "git extras update", which will produce a broken install under Homebrew
    # https://github.com/Homebrew/homebrew/issues/44520
    # https://github.com/tj/git-extras/pull/491
    patch :DATA
  end

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "eff9e393ac4b8e59a40ecb75152cf2bcfed171b7cb296d80606b99ad5ca81ec0" => :sierra
    sha256 "eff9e393ac4b8e59a40ecb75152cf2bcfed171b7cb296d80606b99ad5ca81ec0" => :el_capitan
    sha256 "eff9e393ac4b8e59a40ecb75152cf2bcfed171b7cb296d80606b99ad5ca81ec0" => :yosemite
=======
    sha256 "71b6a0f17408538d948aeefd6badf4a36e1228a6edcd0ce5a950f2e7ee96fd87" => :sierra
    sha256 "efbef7117744b5cba7962be7c607bb216c7d84bf899867017b372bb99e47675b" => :el_capitan
    sha256 "efbef7117744b5cba7962be7c607bb216c7d84bf899867017b372bb99e47675b" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  conflicts_with "git-town",
    :because => "git-extras also ships a git-sync binary"
  conflicts_with "git-utils",
    :because => "both install a `git-pull-request` script"

  def install
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    system "git", "init"
    assert_match(/#{testpath}/, shell_output("#{bin}/git-root"))
  end
end

__END__
diff --git a/bin/git-extras b/bin/git-extras
<<<<<<< HEAD
index 3856179..e2ac72c 100755
--- a/bin/git-extras
+++ b/bin/git-extras
@@ -4,13 +4,12 @@ VERSION="4.0.0"
 INSTALL_SCRIPT="https://raw.githubusercontent.com/tj/git-extras/master/install.sh"

 update() {
-  local bin=$(which git-extras)
=======
index e49cd24..4ae28b5 100755
--- a/bin/git-extras
+++ b/bin/git-extras
@@ -4,13 +4,12 @@ VERSION="4.3.0"
 INSTALL_SCRIPT="https://raw.githubusercontent.com/tj/git-extras/master/install.sh"

 update() {
-  local bin="$(which git-extras)"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
-  local prefix=${bin%/*/*}
-  local orig=$PWD
-
-  curl -s $INSTALL_SCRIPT | PREFIX="$prefix" bash /dev/stdin \
-    && cd "$orig" \
-    && echo "... updated git-extras $VERSION -> $(git extras --version)"
+  echo "This git-extras installation is managed by Homebrew."
+  echo "If you'd like to update git-extras, run the following:"
+  echo
+  echo "  brew upgrade git-extras"
+  echo
+  return 1
 }

 updateForWindows() {
