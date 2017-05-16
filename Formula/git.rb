class Git < Formula
  desc "Distributed revision control system"
  homepage "https://git-scm.com"
<<<<<<< HEAD
  url "https://www.kernel.org/pub/software/scm/git/git-2.12.2.tar.xz"
  sha256 "d21a9e23506e618d561fb25a8a7bd6134f927b86147930103487117a7a678c4a"
  head "https://github.com/git/git.git", :shallow => false

  bottle do
    sha256 "b2f5e8d1be066285f723d17173d1c6cd854ebd419dc3e440bb18e277b09ae22c" => :sierra
    sha256 "7f17f19cce5cee6509ab3c5c5ceb6e74bc5bd198c2488752c4e32d1478771225" => :el_capitan
    sha256 "ffada28a5ff7e7c2c0de2d2dfb5eac0396faeb24d4bdbc929a5177e23aadb81f" => :yosemite
=======
  url "https://www.kernel.org/pub/software/scm/git/git-2.13.0.tar.xz"
  sha256 "4bbf2ab6f2341253a38f95306ec7936833eb1c42572da5c1fa61f0abb2191258"
  head "https://github.com/git/git.git", :shallow => false

  bottle do
    sha256 "2ea9dc535dd4272dde0e17d3ae05525709f3cba3ed1f0189ee3e65fc95c29c75" => :sierra
    sha256 "89cf27990304b5a4b51b14d357003e5007b370972fda4fb0fcb220a4a82a84aa" => :el_capitan
    sha256 "e665c7308b2dd2c2f131058227f91b1024cfc2cf53901e5b544eda19ec0fd93b" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  option "with-blk-sha1", "Compile with the block-optimized SHA1 implementation"
  option "without-completions", "Disable bash/zsh completions from 'contrib' directory"
<<<<<<< HEAD
  option "with-brewed-openssl", "Build with Homebrew OpenSSL instead of the system version"
  option "with-brewed-curl", "Use Homebrew's version of cURL library"
  option "with-brewed-svn", "Use Homebrew's version of SVN"
  option "with-persistent-https", "Build git-remote-persistent-https from 'contrib' directory"

  depends_on "pcre" => :optional
  depends_on "gettext" => :optional
  depends_on "openssl" if build.with? "brewed-openssl"
  depends_on "curl" if build.with? "brewed-curl"
  depends_on "go" => :build if build.with? "persistent-https"
  # Trigger an install of swig before subversion, as the "swig" doesn't get pulled in otherwise
  # See https://github.com/Homebrew/homebrew/issues/34554
  if build.with? "brewed-svn"
    depends_on "swig"
    depends_on "subversion" => "with-perl"
  end

  resource "html" do
    url "https://www.kernel.org/pub/software/scm/git/git-htmldocs-2.12.2.tar.xz"
    sha256 "6f656085c2fdca94df1cc3eb8624c38099f920318c428e34ef0333ecf7f4cd59"
  end

  resource "man" do
    url "https://www.kernel.org/pub/software/scm/git/git-manpages-2.12.2.tar.xz"
    sha256 "7ed1da04e6b0f7fb54a3c7546c6a30fe999b5c8ffcf5e3418521e7550b7f9558"
=======
  option "with-openssl", "Build with Homebrew's OpenSSL instead of using CommonCrypto"
  option "with-curl", "Use Homebrew's version of cURL library"
  option "with-subversion", "Use Homebrew's version of SVN"
  option "with-persistent-https", "Build git-remote-persistent-https from 'contrib' directory"

  deprecated_option "with-brewed-openssl" => "with-openssl"
  deprecated_option "with-brewed-curl" => "with-curl"
  deprecated_option "with-brewed-svn" => "with-subversion"

  depends_on "pcre" => :optional
  depends_on "gettext" => :optional
  depends_on "openssl" => :optional
  depends_on "curl" => :optional
  depends_on "go" => :build if build.with? "persistent-https"

  if build.with? "subversion"
    depends_on "subversion"
    depends_on :perl => ["5.6", :recommended]
  else
    option "with-perl", "Build against a custom Perl rather than system default"
    depends_on :perl => ["5.6", :optional]
  end

  resource "html" do
    url "https://www.kernel.org/pub/software/scm/git/git-htmldocs-2.13.0.tar.xz"
    sha256 "d5ddfb8eedd5a53c0e46e183ed1513dbdd4f5d5e7ef6624040ba0b7381221e3a"
  end

  resource "man" do
    url "https://www.kernel.org/pub/software/scm/git/git-manpages-2.13.0.tar.xz"
    sha256 "8414f9c62e2b099cd0ea2ca22c55fb6538b13fc7a3ed1508fb9881aae42a97c9"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  def install
    # If these things are installed, tell Git build system not to use them
    ENV["NO_FINK"] = "1"
    ENV["NO_DARWIN_PORTS"] = "1"
    ENV["V"] = "1" # build verbosely
    ENV["NO_R_TO_GCC_LINKER"] = "1" # pass arguments to LD correctly
<<<<<<< HEAD
    ENV["PYTHON_PATH"] = which "python"
    ENV["PERL_PATH"] = which "perl"

    perl_version = /\d\.\d+/.match(`perl --version`)

    if build.with? "brewed-svn"
      ENV["PERLLIB_EXTRA"] = %W[
        #{Formula["subversion"].opt_lib}/perl5/site_perl
        #{Formula["subversion"].opt_prefix}/Library/Perl/#{perl_version}/darwin-thread-multi-2level
      ].join(":")
=======
    ENV["PYTHON_PATH"] = which("python")
    ENV["PERL_PATH"] = which("perl")

    perl_version = Utils.popen_read("perl --version")[/v(\d+\.\d+)(?:\.\d+)?/, 1]
    # If building with a non-system Perl search everywhere declared in @INC.
    perl_inc = Utils.popen_read("perl -e 'print join\":\",@INC'").sub(":.", "")

    if build.with? "subversion"
      ENV["PERLLIB_EXTRA"] = %W[
        #{Formula["subversion"].opt_lib}/perl5/site_perl
      ].join(":")
    elsif build.with? "perl"
      ENV["PERLLIB_EXTRA"] = perl_inc
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
    elsif MacOS.version >= :mavericks
      ENV["PERLLIB_EXTRA"] = %W[
        #{MacOS.active_developer_dir}
        /Library/Developer/CommandLineTools
        /Applications/Xcode.app/Contents/Developer
      ].uniq.map do |p|
        "#{p}/Library/Perl/#{perl_version}/darwin-thread-multi-2level"
      end.join(":")
    end

    unless quiet_system ENV["PERL_PATH"], "-e", "use ExtUtils::MakeMaker"
      ENV["NO_PERL_MAKEMAKER"] = "1"
    end

    ENV["BLK_SHA1"] = "1" if build.with? "blk-sha1"

    if build.with? "pcre"
      ENV["USE_LIBPCRE"] = "1"
      ENV["LIBPCREDIR"] = Formula["pcre"].opt_prefix
    end

    ENV["NO_GETTEXT"] = "1" if build.without? "gettext"

    args = %W[
      prefix=#{prefix}
      sysconfdir=#{etc}
      CC=#{ENV.cc}
      CFLAGS=#{ENV.cflags}
      LDFLAGS=#{ENV.ldflags}
    ]

<<<<<<< HEAD
    if build.with? "brewed-openssl"
=======
    if build.with? "openssl"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
      openssl_prefix = Formula["openssl"].opt_prefix
      args += %W[NO_APPLE_COMMON_CRYPTO=1 OPENSSLDIR=#{openssl_prefix}]
    else
      args += %w[NO_OPENSSL=1 APPLE_COMMON_CRYPTO=1]
    end

    system "make", "install", *args

    # Install the macOS keychain credential helper
    cd "contrib/credential/osxkeychain" do
      system "make", "CC=#{ENV.cc}",
                     "CFLAGS=#{ENV.cflags}",
                     "LDFLAGS=#{ENV.ldflags}"
      bin.install "git-credential-osxkeychain"
      system "make", "clean"
    end

    # Install the netrc credential helper
    cd "contrib/credential/netrc" do
      system "make", "test"
      bin.install "git-credential-netrc"
    end

    # Install git-subtree
    cd "contrib/subtree" do
      system "make", "CC=#{ENV.cc}",
                     "CFLAGS=#{ENV.cflags}",
                     "LDFLAGS=#{ENV.ldflags}"
      bin.install "git-subtree"
    end

    if build.with? "persistent-https"
      cd "contrib/persistent-https" do
        system "make"
        bin.install "git-remote-persistent-http",
                    "git-remote-persistent-https",
                    "git-remote-persistent-https--proxy"
      end
    end

    if build.with? "completions"
      # install the completion script first because it is inside "contrib"
      bash_completion.install "contrib/completion/git-completion.bash"
      bash_completion.install "contrib/completion/git-prompt.sh"

      zsh_completion.install "contrib/completion/git-completion.zsh" => "_git"
      cp "#{bash_completion}/git-completion.bash", zsh_completion
    end

    elisp.install Dir["contrib/emacs/*.el"]
    (share/"git-core").install "contrib"

    # We could build the manpages ourselves, but the build process depends
    # on many other packages, and is somewhat crazy, this way is easier.
    man.install resource("man")
    (share/"doc/git-doc").install resource("html")

    # Make html docs world-readable
    chmod 0644, Dir["#{share}/doc/git-doc/**/*.{html,txt}"]
    chmod 0755, Dir["#{share}/doc/git-doc/{RelNotes,howto,technical}"]

    # To avoid this feature hooking into the system OpenSSL, remove it.
<<<<<<< HEAD
    # If you need it, install git --with-brewed-openssl.
    rm "#{libexec}/git-core/git-imap-send" if build.without? "brewed-openssl"
=======
    # If you need it, install git --with-openssl.
    rm "#{libexec}/git-core/git-imap-send" if build.without? "openssl"

    # This is only created when building against system Perl, but it isn't
    # purged by Homebrew's post-install cleaner because that doesn't check
    # "Library" directories. It is however pointless to keep around as it
    # only contains the perllocal.pod installation file.
    rm_rf prefix/"Library/Perl"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.

    # Set the macOS keychain credential helper by default
    # (as Apple's CLT's git also does this).
    (buildpath/"gitconfig").write <<-EOS.undent
      [credential]
      \thelper = osxkeychain
    EOS
    etc.install "gitconfig"
  end

  test do
    system bin/"git", "init"
    %w[haunted house].each { |f| touch testpath/f }
    system bin/"git", "add", "haunted", "house"
    system bin/"git", "commit", "-a", "-m", "Initial Commit"
    assert_equal "haunted\nhouse", shell_output("#{bin}/git ls-files").strip
  end
end
