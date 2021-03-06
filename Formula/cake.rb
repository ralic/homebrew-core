class Cake < Formula
  desc "Cross platform build automation system with a C# DSL."
  homepage "http://cakebuild.net/"
<<<<<<< HEAD
  url "https://github.com/cake-build/cake/releases/download/v0.19.4/Cake-bin-net45-v0.19.4.zip"
  sha256 "1f4a91701fd79afc49c7f16108798d55cd89f84da4e000d1c5ba20a5e68360b0"
=======
  url "https://github.com/cake-build/cake/releases/download/v0.19.5/Cake-bin-net45-v0.19.5.zip"
  sha256 "4b85f2f0b0d9f5df38f5bfa04a98ee8ea02d2819dafa7801b9405427804aef96"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.

  bottle :unneeded

  depends_on "mono" => :recommended

  def install
    libexec.install Dir["*.dll"]
    libexec.install Dir["*.exe"]
    libexec.install Dir["*.xml"]

    bin.mkpath
    (bin/"cake").write <<-EOS.undent
      #!/bin/bash
      mono #{libexec}/Cake.exe "$@"
    EOS
  end

  test do
    (testpath/"build.cake").write <<-EOS.undent
      var target = Argument ("target", "info");

      Task("info").Does(() =>
      {
        Information ("Hello Homebrew");
      });

      RunTarget ("info");
    EOS
    assert_match "Hello Homebrew\n", shell_output("#{bin}/cake build.cake")
  end
end
