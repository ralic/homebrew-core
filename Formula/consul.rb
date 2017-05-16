class Consul < Formula
  desc "Tool for service discovery, monitoring and configuration"
  homepage "https://www.consul.io"
  url "https://github.com/hashicorp/consul.git",
<<<<<<< HEAD
      :tag => "v0.8.1",
      :revision => "e9ca44d0a1757ac9aecc6785904a701936c10e4a"
=======
      :tag => "v0.8.3",
      :revision => "ea2a82b221c3e0a466a4f38ab4e8718ad8c60621"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.

  head "https://github.com/hashicorp/consul.git",
       :shallow => false

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "11a9f43bc721b159c5a269a6fa2adfd5585eb80317fe2c31ce342ca4b1eed1bc" => :sierra
    sha256 "8d88805e6c8be2330ecc29f103d03f6c94b796777f13796e9904fe8fde79200f" => :el_capitan
    sha256 "13df2c27a92014e78613319b98888ba7aaade08cd01fcc1348415bebc083f6cc" => :yosemite
=======
    sha256 "81376236b216648d7314e43533dd076a2d2b6af549699270577265e83c2c316f" => :sierra
    sha256 "db9abd411d005e4df6ad2b4a626d7e316671b2485c055609e8ac02b81d859f81" => :el_capitan
    sha256 "3465a75f56f5e782033d7e35bb6e6c0dc2aa3e1bb5cf44eaef9d6e37aadaff2f" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  option "with-web-ui", "Installs the consul web ui"

  depends_on "go" => :build

  resource "web-ui" do
<<<<<<< HEAD
    url "https://releases.hashicorp.com/consul/0.8.1/consul_0.8.1_web_ui.zip"
    sha256 "0caff8d54a80ff7bc5baec39b0eda19a9652df992db324026e361fa31183749f"
=======
    url "https://releases.hashicorp.com/consul/0.8.2/consul_0.8.2_web_ui.zip"
    sha256 "81e6da2e679c0235ef42c6f4054045603e12e51850d979cba9c2d4fe06723131"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  def install
    contents = Dir["{*,.git,.gitignore}"]
    gopath = buildpath/"gopath"
    (gopath/"src/github.com/hashicorp/consul").install contents

    ENV["GOPATH"] = gopath
    ENV.prepend_create_path "PATH", gopath/"bin"

    cd gopath/"src/github.com/hashicorp/consul" do
      system "make"
      bin.install "bin/consul"
      zsh_completion.install "contrib/zsh-completion/_consul"
    end

    # install web-ui to package share folder.
    (pkgshare/"web-ui").install resource("web-ui") if build.with? "web-ui"
  end

  def caveats; <<-EOS.undent
    If consul was built with --with-web-ui, you can activate the UI by running
    consul with `-ui-dir #{pkgshare}/web-ui`.
    EOS
  end

  plist_options :manual => "consul agent -dev -advertise 127.0.0.1"

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>KeepAlive</key>
        <dict>
          <key>SuccessfulExit</key>
          <false/>
        </dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/consul</string>
          <string>agent</string>
          <string>-dev</string>
          <string>-advertise</string>
          <string>127.0.0.1</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>WorkingDirectory</key>
        <string>#{var}</string>
        <key>StandardErrorPath</key>
        <string>#{var}/log/consul.log</string>
        <key>StandardOutPath</key>
        <string>#{var}/log/consul.log</string>
      </dict>
    </plist>
    EOS
  end

  test do
    fork do
      exec "#{bin}/consul", "agent", "-data-dir", ".", "-server", "-bootstrap"
    end
    sleep 30
    system "#{bin}/consul", "info"
    system "#{bin}/consul", "leave"
  end
end
