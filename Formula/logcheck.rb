class Logcheck < Formula
  desc "Mail anomalies in the system logfiles to the administrator"
  homepage "https://logcheck.alioth.debian.org/"
<<<<<<< HEAD
  url "https://mirrors.ocf.berkeley.edu/debian/pool/main/l/logcheck/logcheck_1.3.17.tar.xz"
  mirror "https://mirrorservice.org/sites/ftp.debian.org/debian/pool/main/l/logcheck/logcheck_1.3.17.tar.xz"
  sha256 "c2d3fc323e8c6555e91d956385dbfd0f67b55872ed0f6a7ad8ad2526a9faf03a"

  bottle do
    cellar :any_skip_relocation
    rebuild 3
    sha256 "7fe24461210fc2d5f4809e08566e85e010a2715b9b7a6426f686327f40f25cdf" => :sierra
    sha256 "aab0ab066fe378c88c74b9783a90fb0a4896dd3a6258d00b08cd1d0d2987b108" => :el_capitan
    sha256 "c75e01fb14bdd0adfc04e110a3c8a65d036b9bd71ac03a6ac58d69006a892fe9" => :yosemite
    sha256 "25f2dfec7bb30fded535bdb354767a2680108dcd93d0627f8384a115c008cf89" => :mavericks
=======
  url "https://mirrors.ocf.berkeley.edu/debian/pool/main/l/logcheck/logcheck_1.3.18.tar.xz"
  mirror "https://mirrorservice.org/sites/ftp.debian.org/debian/pool/main/l/logcheck/logcheck_1.3.18.tar.xz"
  sha256 "077b9149ccd2b747b52785afa89da844f3d072c017c9e719925dec6acb9a9af4"

  bottle do
    cellar :any_skip_relocation
    sha256 "ce71670cdeba739650cd716867e12cda182a948189a68ca565d318299f847a61" => :sierra
    sha256 "94fde1124326dc8ed8428878b84db52b22b4ce1c19949ee0dd170402164cbadd" => :el_capitan
    sha256 "94fde1124326dc8ed8428878b84db52b22b4ce1c19949ee0dd170402164cbadd" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  def install
    inreplace "Makefile", "$(DESTDIR)/$(CONFDIR)", "$(CONFDIR)"
<<<<<<< HEAD
    # email sent to logcheck mailing list asking whether this patch can land upstream:
    # https://lists.alioth.debian.org/pipermail/logcheck-users/2015-December/000328.html
    inreplace "src/logcheck-test", "mktemp --tmpdir logcheck-test", "mktemp /tmp/logcheck-test"

=======
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
    system "make", "install", "--always-make", "DESTDIR=#{prefix}",
                   "SBINDIR=sbin", "BINDIR=bin", "CONFDIR=#{etc}/logcheck"
  end

  test do
    (testpath/"README").write "Boaty McBoatface"
    output = shell_output("#{sbin}/logtail -f #{testpath}/README")
    assert_match "Boaty McBoatface", output
  end
end
