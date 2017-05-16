class Gradle < Formula
  desc "Build system based on the Groovy language"
  homepage "https://www.gradle.org/"
<<<<<<< HEAD
  url "https://services.gradle.org/distributions-snapshots/gradle-4.0-20170426102539+0000-bin.zip"
  sha256 "4e502f1c152c0df787e7cd8fcb043c3d03a8c65cf1d8ae46c9475ddbc80ceebb"
=======
  url "https://services.gradle.org/distributions/gradle-3.5-all.zip"
  sha256 "d84bf6b6113da081d0082bcb63bd8547824c6967fe68704d1e3a6fde822b7212"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.

  bottle :unneeded

  option "with-all", "Installs Javadoc, examples, and source in addition to the binaries"

  depends_on :java => "1.7+"

  def install
    libexec.install %w[bin lib]
    libexec.install %w[docs media samples src] if build.with? "all"
    bin.install_symlink libexec/"bin/gradle"
  end

  test do
    ENV.java_cache
    assert_match version.to_s, shell_output("#{bin}/gradle --version")
  end
end
