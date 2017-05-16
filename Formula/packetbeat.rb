class Packetbeat < Formula
  desc "Lightweight Shipper for Network Data"
  homepage "https://www.elastic.co/products/beats/packetbeat"
<<<<<<< HEAD
  url "https://github.com/elastic/beats/archive/v5.3.2.tar.gz"
  sha256 "e8c765531276e4731c5148bd99fad1efc799f3ec68e1d32a2fe116995f2b9e2f"
=======
  url "https://github.com/elastic/beats/archive/v5.4.0.tar.gz"
  sha256 "d236f9433d48b69cc2f0bf3617f17d5f2eec261acee96cc28d8b72be84afc0a7"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.

  head "https://github.com/elastic/beats.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "c4bdcfb41c81fc67ccd29000d2c9438751b9f0d8cf1912afd44c718820876fe1" => :sierra
    sha256 "73f25ca21b3e368152ceb3f147d469d5100fd14d086c05fa616234864ea5c277" => :el_capitan
    sha256 "70c7f8d9105995d7c9302542e35d9a6cb79695fefd26e1e3d33429625927a88a" => :yosemite
=======
    sha256 "377e8d4d0d2a730678832c737b07e67e6e6d3642b6ee8721980f7c55da4c66ba" => :sierra
    sha256 "4a8ca3f2711347d6d457851d6fc626431bdc0e90e1280d6f3764005a23a3c8da" => :el_capitan
    sha256 "5eb66f54a333b1be8e70498b5e093b6b599b84cf299420a54d1a0564387c6584" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "go" => :build

  def install
    gopath = buildpath/"gopath"
    (gopath/"src/github.com/elastic/beats").install Dir["{*,.git,.gitignore}"]

    ENV["GOPATH"] = gopath

    cd gopath/"src/github.com/elastic/beats/packetbeat" do
      system "make"
      libexec.install "packetbeat"

      inreplace "packetbeat.yml", "packetbeat.interfaces.device: any", "packetbeat.interfaces.device: en0"

      (etc/"packetbeat").install("packetbeat.yml", "packetbeat.template.json", "packetbeat.template-es2x.json")
    end

    (bin/"packetbeat").write <<-EOS.undent
      #!/bin/sh
      exec #{libexec}/packetbeat -path.config #{etc}/packetbeat \
        -path.home #{prefix} -path.logs #{var}/log/packetbeat \
        -path.data #{var}/packetbeat $@
    EOS
  end

  plist_options :manual => "packetbeat"

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN"
    "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>Program</key>
        <string>#{opt_bin}/packetbeat</string>
        <key>RunAtLoad</key>
        <true/>
      </dict>
    </plist>
  EOS
  end

  test do
    system "#{bin}/packetbeat", "--devices"
  end
end
