class AppEngineJava < Formula
  desc "Google App Engine for Java"
  homepage "https://cloud.google.com/appengine/docs/java/"
<<<<<<< HEAD
  url "https://storage.googleapis.com/appengine-sdks/featured/appengine-java-sdk-1.9.51.zip"
  sha256 "f24cf8d8773cde0ce1c78a468d9a15cb824e9c99182c03216d398071f6024f8d"
=======
  url "https://storage.googleapis.com/appengine-sdks/featured/appengine-java-sdk-1.9.53.zip"
  sha256 "0383ff96a84de0efa15799eaca3bf41fd7466879d688ff021fc3c72d747472bb"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.

  bottle :unneeded

  depends_on :java => "1.7+"

  def install
    rm Dir["bin/*.cmd"]
    libexec.install Dir["*"]
    bin.write_exec_script %w[appcfg.sh dev_appserver.sh endpoints.sh google_sql.sh].map { |fn| libexec/"bin/#{fn}" }
  end

  test do
    (testpath/"WEB-INF/web.xml").write "<web-app/>"
    (testpath/"WEB-INF/appengine-web.xml").write "<appengine-web-app><threadsafe>true</threadsafe></appengine-web-app>"
    Process.setsid
    IO.popen("#{bin}/dev_appserver.sh . 2>&1") do |io|
      assert_not_nil(io.gets, "Dev App Server terminated prematurely") until $_ == "INFO: Dev App Server is now running\n"
      Signal.trap "INT", "IGNORE"
      Process.kill "INT", 0
    end
    assert_equal(130, $?.exitstatus, "Dev App Server exited with unexpected status code")
  end
end
