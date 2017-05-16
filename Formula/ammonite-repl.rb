class AmmoniteRepl < Formula
  desc "Ammonite is a cleanroom re-implementation of the Scala REPL"
  homepage "https://lihaoyi.github.io/Ammonite/#Ammonite-REPL"
<<<<<<< HEAD
  url "https://github.com/lihaoyi/Ammonite/releases/download/0.8.4/2.12-0.8.4", :using => :nounzip
  sha256 "55965f2703c14e1be3100f3541c3b8961135e76f7ebd3961437c94e611887612"
=======
  url "https://github.com/lihaoyi/Ammonite/releases/download/0.8.5/2.12-0.8.5", :using => :nounzip
  sha256 "5d5bda7289214dc9704367bddf6866a68100c4fe67b83e1a775c4dcb51e006d8"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.

  bottle :unneeded

  depends_on :java => "1.8+"

  def install
    bin.install Dir["*"].shift => "amm"
  end

  test do
    ENV["_JAVA_OPTIONS"] = "-Duser.home=#{testpath}"
    output = shell_output("#{bin}/amm -c 'print(\"hello world!\")'")
    assert_equal "hello world!", output.lines.last
  end
end
