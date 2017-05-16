class ApacheFlink < Formula
  desc "Scalable batch and stream data processing"
  homepage "https://flink.apache.org/"
<<<<<<< HEAD
  url "https://www.apache.org/dyn/closer.lua?path=flink/flink-1.2.0/flink-1.2.0-bin-hadoop27-scala_2.11.tgz"
  version "1.2.0"
  sha256 "ccb37938fef54236252a3e895cdca63d881c6138515109b4ad4da2a0fb9b8ac8"
=======
  url "https://www.apache.org/dyn/closer.lua?path=flink/flink-1.2.1/flink-1.2.1-bin-hadoop27-scala_2.11.tgz"
  version "1.2.1"
  sha256 "903dfdb0141c141d120a28653666cf9cbd8d86cd3bcc7540a058fae03aeccd90"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/apache/flink.git"

  bottle :unneeded

<<<<<<< HEAD
=======
  depends_on :java => "1.7+"

>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  def install
    rm_f Dir["bin/*.bat"]
    libexec.install Dir["*"]
    bin.write_exec_script Dir["#{libexec}/bin/flink"]
  end

  test do
    ENV["_JAVA_OPTIONS"] = "-Djava.io.tmpdir=#{testpath} -Duser.home=#{testpath}"
    input = "benv.fromElements(1,2,3).print()\n"
    output = pipe_output("#{libexec}/bin/start-scala-shell.sh local", input, 1)
    assert_match "FINISHED", output
  end
end
