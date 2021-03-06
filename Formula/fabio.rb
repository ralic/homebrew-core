class Fabio < Formula
  desc "Zero-conf load balancing HTTP(S) router"
  homepage "https://github.com/fabiolb/fabio"
<<<<<<< HEAD
  url "https://github.com/fabiolb/fabio/archive/v1.4.3.tar.gz"
  sha256 "9afdf89bbe5e1a5cf17cbffe255d75cfc51f170c8d30f64e659317f82aed042f"
=======
  url "https://github.com/fabiolb/fabio/archive/v1.4.4.tar.gz"
  sha256 "eb2c6773047b95efc7f4f2d7fddd3525d39df502e10be519f20e6107efec08e6"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/fabiolb/fabio.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "74d35ccc0a7363cfa9594d4bce89dd8f5288ec129d90b917c721a58c3e606025" => :sierra
    sha256 "3dd75e43c419f4b5e0a708affd6a79fb872bec225c8e3d7b19d6a6b0b62cfa93" => :el_capitan
    sha256 "818563ba0fc4782679bf2bc1ad7d28e425d965dd1871e66da825cf91cec03681" => :yosemite
=======
    sha256 "9d427ae2b30ee5b77d22b9d413852264efd4c32df6cf6b84b319ca1a12641799" => :sierra
    sha256 "bed721d4fe7fe5c6ae053596176a4b53597094ea60c306acb2c6fb296007748c" => :el_capitan
    sha256 "651d7a488a6b8d1a197cd0f15b9fde6b50e8ef0537bb16e18fd90c211e743280" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "go" => :build
  depends_on "consul" => :recommended

  def install
    mkdir_p buildpath/"src/github.com/fabiolb"
    ln_s buildpath, buildpath/"src/github.com/fabiolb/fabio"

    ENV["GOPATH"] = buildpath.to_s

    system "go", "install", "github.com/fabiolb/fabio"
    bin.install "#{buildpath}/bin/fabio"
  end

  test do
    require "socket"
    require "timeout"

    CONSUL_DEFAULT_PORT = 8500
    FABIO_DEFAULT_PORT = 9999
    LOCALHOST_IP = "127.0.0.1".freeze

    def port_open?(ip, port, seconds = 1)
      Timeout.timeout(seconds) do
        begin
          TCPSocket.new(ip, port).close
          true
        rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
          false
        end
      end
    rescue Timeout::Error
      false
    end

    if !port_open?(LOCALHOST_IP, FABIO_DEFAULT_PORT)
      if !port_open?(LOCALHOST_IP, CONSUL_DEFAULT_PORT)
        fork do
          exec "consul agent -dev -bind 127.0.0.1"
          puts "consul started"
        end
        sleep 15
      else
        puts "Consul already running"
      end
      fork do
        exec "#{bin}/fabio &>fabio-start.out&"
        puts "fabio started"
      end
      sleep 5
      assert_equal true, port_open?(LOCALHOST_IP, FABIO_DEFAULT_PORT)
      system "killall", "fabio" # fabio forks off from the fork...
      system "consul", "leave"
    else
      puts "Fabio already running or Consul not available or starting fabio failed."
      false
    end
  end
end
