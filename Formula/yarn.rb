class Yarn < Formula
  desc "JavaScript package manager"
  homepage "https://yarnpkg.com/"
<<<<<<< HEAD
  url "https://yarnpkg.com/downloads/0.23.3/yarn-v0.23.3.tar.gz"
  sha256 "9f7569b9b89bbe4c3c0bbd8917f551ec26935802668b6e6139ea45db67e3a314"
=======
  url "https://yarnpkg.com/downloads/0.24.4/yarn-v0.24.4.tar.gz"
  sha256 "90ab424615f7f24a2e2895f33b90bdd4be0e93ebd56083adff4fafa718a75e68"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/yarnpkg/yarn.git"

  bottle :unneeded

  depends_on "node"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/yarn.js" => "yarn"
    bin.install_symlink "#{libexec}/bin/yarn.js" => "yarnpkg"
    inreplace "#{libexec}/package.json", '"installationMethod": "tar"', '"installationMethod": "homebrew"'
  end

  test do
    (testpath/"package.json").write('{"name": "test"}')
    system bin/"yarn", "add", "jquery"
  end
end
