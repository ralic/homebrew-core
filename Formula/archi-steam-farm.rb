class ArchiSteamFarm < Formula
  desc "ASF is a C# application that allows you to farm steam cards"
  homepage "https://github.com/JustArchi/ArchiSteamFarm"
<<<<<<< HEAD
  url "https://github.com/JustArchi/ArchiSteamFarm/releases/download/2.3.1.2/ASF.zip"
  version "2.3.1.2"
  sha256 "6d337b57195555fcce0ac30859ee1f67570de00ec7bc30d1785e05dde896e396"

  bottle do
    cellar :any_skip_relocation
    sha256 "2c77afdf025667c284ac48c18d74e96bd4c074ed1ccb5706b0721fa48491bcdf" => :sierra
    sha256 "4f6c5cde134fd92d8f89f4822c91f0f4c54a4408245aed51f66242795529b7a9" => :el_capitan
    sha256 "4f6c5cde134fd92d8f89f4822c91f0f4c54a4408245aed51f66242795529b7a9" => :yosemite
=======
  url "https://github.com/JustArchi/ArchiSteamFarm/releases/download/2.3.1.4/ASF.zip"
  version "2.3.1.4"
  sha256 "73941584b97a8b4820a5c4587e033092873f520ff88dbe9b8da085e72b7525bf"

  bottle do
    cellar :any_skip_relocation
    sha256 "7a2e792ce756de3ca77ae63d00073da56b7ba0b599f2583b8e286ba60be63c97" => :sierra
    sha256 "0054489a26c12f9379ad9f79ac959c07e9b4a6d0a387e08400ad8cb978a602d8" => :el_capitan
    sha256 "0054489a26c12f9379ad9f79ac959c07e9b4a6d0a387e08400ad8cb978a602d8" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "mono"

  def install
    libexec.install "ASF.exe"
    (bin/"asf").write <<-EOS.undent
      #!/bin/bash
      mono #{libexec}/ASF.exe "$@"
    EOS

    etc.install "config" => "asf"
    libexec.install_symlink etc/"asf" => "config"
  end

  def caveats; <<-EOS.undent
    Config: #{etc}/asf/
    EOS
  end

  test do
    assert_match "ASF V#{version}", shell_output("#{bin}/asf --client")
  end
end
