class Artifactory < Formula
  desc "Manages binaries"
  homepage "https://www.jfrog.com/artifactory/"
<<<<<<< HEAD
  url "https://dl.bintray.com/jfrog/artifactory/jfrog-artifactory-oss-5.2.1.zip"
  sha256 "993d9abd188a6b1eaf4c762f201f0ba70f545ca68ad099f9a9a48bec3470d68d"
=======
  url "https://dl.bintray.com/jfrog/artifactory/jfrog-artifactory-oss-5.3.0.zip"
  sha256 "7ede1581dde6d45bd766eec9881e9b2927bf084ca4ae9804352a2fa9d95e08bd"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.

  bottle :unneeded

  option "with-low-heap", "Run artifactory with low Java memory options. Useful for development machines. Do not use in production."

  depends_on :java => "1.8+"

  def install
    # Remove Windows binaries
    rm_f Dir["bin/*.bat"]
    rm_f Dir["bin/*.exe"]

    # Set correct working directory
    inreplace "bin/artifactory.sh",
      'export ARTIFACTORY_HOME="$(cd "$(dirname "${artBinDir}")" && pwd)"',
      "export ARTIFACTORY_HOME=#{libexec}"

    if build.with? "low-heap"
      # Reduce memory consumption for non production use
      inreplace "bin/artifactory.default",
        "-server -Xms512m -Xmx2g",
        "-Xms128m -Xmx768m"
    end

    libexec.install Dir["*"]

    # Launch Script
    bin.install_symlink libexec/"bin/artifactory.sh"
    # Memory Options
    bin.install_symlink libexec/"bin/artifactory.default"
  end

  def post_install
    # Create persistent data directory. Artifactory heavily relies on the data
    # directory being directly under ARTIFACTORY_HOME.
    # Therefore, we symlink the data dir to var.
    data = var/"artifactory"
    data.mkpath

    libexec.install_symlink data => "data"
  end

  plist_options :manual => "#{HOMEBREW_PREFIX}/opt/artifactory/libexec/bin/artifactory.sh"

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>com.jfrog.artifactory</string>

        <key>WorkingDirectory</key>
        <string>#{libexec}</string>

        <key>Program</key>
        <string>#{bin}/artifactory.sh</string>

        <key>KeepAlive</key>
        <true/>
      </dict>
    </plist>
  EOS
  end

  test do
    assert_match "Checking arguments to Artifactory", pipe_output("#{bin}/artifactory.sh check")
  end
end
