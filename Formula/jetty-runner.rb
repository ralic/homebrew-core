class JettyRunner < Formula
  desc "Use Jetty without an installed distribution"
  homepage "https://www.eclipse.org/jetty/"
<<<<<<< HEAD
  url "https://search.maven.org/remotecontent?filepath=org/eclipse/jetty/jetty-runner/9.4.4.v20170414/jetty-runner-9.4.4.v20170414.jar"
  version "9.4.4.v20170414"
  sha256 "74ad2889dadf93b1c0ec3b8359dcb079121ad4e3b212f461882e692880d66277"
=======
  url "https://search.maven.org/remotecontent?filepath=org/eclipse/jetty/jetty-runner/9.4.5.v20170502/jetty-runner-9.4.5.v20170502.jar"
  version "9.4.5.v20170502"
  sha256 "2b39981fb0b1006aec83eeb1e6b3af9b9d7941ec20ae872ba47322e1e89d802c"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.

  bottle :unneeded

  depends_on :java => "1.8+"

  def install
    libexec.install Dir["*"]

    bin.mkpath
    bin.write_jar_script libexec/"jetty-runner-#{version}.jar", "jetty-runner"
  end

  test do
    ENV.append "_JAVA_OPTIONS", "-Djava.io.tmpdir=#{testpath}"
    touch "#{testpath}/test.war"

    pid = fork do
      exec "#{bin}/jetty-runner test.war"
    end
    sleep 5

    begin
      output = shell_output("curl -I http://localhost:8080")
      assert_match %r{HTTP\/1\.1 200 OK}, output
    ensure
      Process.kill 9, pid
      Process.wait pid
    end
  end
end
