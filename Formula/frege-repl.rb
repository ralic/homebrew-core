class FregeRepl < Formula
  desc "REPL (read-eval-print loop) for Frege"
  homepage "https://github.com/Frege/frege-repl"
  url "https://github.com/Frege/frege-repl/releases/download/1.4-SNAPSHOT/frege-repl-1.4-SNAPSHOT.zip"
  version "1.4-SNAPSHOT"
<<<<<<< HEAD
  sha256 "2cf1c2a8f7b64c9d70b21fbfd25b2af3f5e3bebe3662f724afd435d01bddafec"
=======
  sha256 "2ca5f13bc5efaf8515381e8cdf99b4d4017264a462a30366a873cb54cc4f4640"
  revision 1
>>>>>>> kettle: fix hardcoded /usr/local idiocy.

  bottle :unneeded

  depends_on :java => "1.8+"

  def install
    rm_f Dir["bin/*.bat"]
    libexec.install "bin", "lib"
    bin.install_symlink "#{libexec}/bin/frege-repl"
  end

  test do
    assert_match "65536", pipe_output("#{bin}/frege-repl", "println $ 64*1024\n:quit\n")
  end
end
