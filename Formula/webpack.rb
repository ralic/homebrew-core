require "language/node"

class Webpack < Formula
  desc "Bundler for JavaScript and friends"
  homepage "https://webpack.js.org/"
<<<<<<< HEAD
  url "https://registry.npmjs.org/webpack/-/webpack-2.4.1.tgz"
  sha256 "6c7998db7719986842886b77cbabb137639bc06541d093b567a4882c934bd61b"
=======
  url "https://registry.npmjs.org/webpack/-/webpack-2.5.1.tgz"
  sha256 "f5abc57f42a4465ab218c019eb211640832fd0f90cc816ed86d023a2bd78d3a6"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/webpack/webpack.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "7d3387e7084970cd6d9be909871b31ec6265bc68acc4861b0732525f938b94af" => :sierra
    sha256 "da1aedef083b3e640fdb1e497ab94d0a6bacc9ce478c9b5774ad7f41a143f7ba" => :el_capitan
    sha256 "c75f4c38f7d38f3dec66f0c0bca7e99ede6d30a3463e77b0c8f058bbed2ac051" => :yosemite
=======
    sha256 "e75cc66d5993b7d058ba372c0376f3896f31a3efa0ddb589733e192970b356b6" => :sierra
    sha256 "acc80a9f6ee55d0610a94f1fb4eb1ee0beb7c31199f9a00f49678e79bd8e48bd" => :el_capitan
    sha256 "7ad861abc2aec1860ba3622ad11999e9bb840080a0bf13a3ab5a1417f1e5cf29" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"index.js").write <<-EOS.undent
      function component () {
        var element = document.createElement('div');
        element.innerHTML = 'Hello' + ' ' + 'webpack';
        return element;
      }

      document.body.appendChild(component());
    EOS

    system bin/"webpack", "index.js", "bundle.js"
    assert File.exist?("bundle.js"), "bundle.js was not generated"
  end
end
