class Zinc < Formula
  desc "Stand-alone version of sbt's Scala incremental compiler"
  homepage "https://github.com/typesafehub/zinc"
<<<<<<< HEAD
  url "https://downloads.typesafe.com/zinc/0.3.13/zinc-0.3.13.tgz"
  sha256 "6ae329abb526afde4ee78480be1f2675310b067e3e143fbb02f429f6f816f996"
=======
  url "https://downloads.typesafe.com/zinc/0.3.15/zinc-0.3.15.tgz"
  sha256 "5ec4df3fa2cbb271d65a5b478c940a9da6ef4902aa8c9d41a76dd253e3334ca7"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.

  bottle :unneeded

  def install
    rm_f Dir["bin/ng/{linux,win}*"]
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/zinc"
  end

  test do
    system "#{bin}/zinc", "-version"
  end
end
