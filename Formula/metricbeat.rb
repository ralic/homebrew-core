class Metricbeat < Formula
  desc "Collect metrics from your systems and services."
  homepage "https://www.elastic.co/products/beats/metricbeat"
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
    sha256 "0226cb9a84ea8b26d617773116c9e5188a0d61f22def9e851a309bf523befd67" => :sierra
    sha256 "42687da880ec269f3dc46faa739c5b9364659026c122872d32a1d08025f85cb1" => :el_capitan
    sha256 "859afe67192209fcaad278a28c8e31f592b50b7b06925eaded6dd6daaee2b567" => :yosemite
=======
    sha256 "29eac77db263feff2f4b6a02158a5c69c3cb53ed0526cc50d720c936c3c87c62" => :sierra
    sha256 "3e5b55b11d6e533a15fbb825546d26394c2d3e61825092db6d63dd440d0dc2fc" => :el_capitan
    sha256 "5f0f0dd11bf9a2413771ad801aef7a70732e4e81d4bfdd9a094fc81d63ae7e10" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "go" => :build

  def install
    gopath = buildpath/"gopath"
    (gopath/"src/github.com/elastic/beats").install Dir["{*,.git,.gitignore}"]

    ENV["GOPATH"] = gopath

    cd gopath/"src/github.com/elastic/beats/metricbeat" do
      system "make"
      libexec.install "metricbeat"

      (etc/"metricbeat").install "metricbeat.yml"
      (etc/"metricbeat").install "metricbeat.template.json"
      (etc/"metricbeat").install "metricbeat.template-es2x.json"
    end

    (bin/"metricbeat").write <<-EOS.undent
      #!/bin/sh
      exec "#{libexec}/metricbeat" --path.config "#{etc}/metricbeat" --path.home="#{prefix}" --path.logs="#{var}/log/metricbeat" --path.data="#{opt_prefix}" "$@"
    EOS
  end

  plist_options :manual => "metricbeat"

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN"
    "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>Program</key>
        <string>#{opt_bin}/metricbeat</string>
        <key>RunAtLoad</key>
        <true/>
      </dict>
    </plist>
  EOS
  end

  test do
    (testpath/"metricbeat.yml").write <<-EOS.undent
      metricbeat.modules:
      - module: system
        metricsets: ["load"]
        period: 1s
      output.file:
        enabled: true
        path: #{testpath}/data
        filename: metricbeat
    EOS

    (testpath/"logs").mkpath
    (testpath/"data").mkpath

    metricbeat_pid = fork do
      exec bin/"metricbeat", "-c", testpath/"metricbeat.yml",
      "--path.data=#{testpath}/data", "--path.logs=#{testpath}/logs"
    end

    begin
      sleep 2
      assert File.exist? testpath/"data/metricbeat"
    ensure
      Process.kill("TERM", metricbeat_pid)
    end
  end
end
