class TerminalNotifier < Formula
  desc "Send macOS User Notifications from the command-line"
  homepage "https://github.com/julienXX/terminal-notifier"
<<<<<<< HEAD
  url "https://github.com/julienXX/terminal-notifier/archive/1.7.1.tar.gz"
  sha256 "6a322a01641d37ca11ed325452bcfce0b312c7bde65cd5afbb53236f1f6b51df"
=======
  url "https://github.com/julienXX/terminal-notifier/archive/1.8.0.tar.gz"
  sha256 "390ae441156c1c621c56ccb3cffa670ba74ee60762bbcf12c92686b749bf232e"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/julienXX/terminal-notifier.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "b4dd06d3c8f082fe3c8246e784661e86fdb7986cdaa9fe65638ba472ef8f43f4" => :sierra
    sha256 "7fad6587bf48c9956c1b0c3ec691a549a34a829850069809b2e3af91710ee5a8" => :el_capitan
    sha256 "2eddadf3bcd3edbfd962325bf5eb4be41f2a3bef8e1305ed48a922c9fe02d027" => :yosemite
=======
    sha256 "ff749a3e3bf23b1c0830b5a9529ffab0b480d1d442ad2babe821e91d0af66eb2" => :sierra
    sha256 "17d17d143099cacf047751eb56a3f7397cf808f56311ccce6be03b784e60501b" => :el_capitan
    sha256 "16aefa24a26c812094ab13e66a9b87d38f5c26e23d6049e0c6d584dde9927afd" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on :macos => :mountain_lion
  depends_on :xcode => :build

  def install
    xcodebuild "-project", "Terminal Notifier.xcodeproj",
               "-target", "terminal-notifier",
               "SYMROOT=build",
<<<<<<< HEAD
               "-verbose"
    prefix.install Dir["build/Release/*"]
    inner_binary = "#{prefix}/terminal-notifier.app/Contents/MacOS/terminal-notifier"
    bin.write_exec_script inner_binary
    chmod 0755, bin/"terminal-notifier"
=======
               "-verbose",
               "CODE_SIGN_IDENTITY="
    bin.install "build/Release/terminal-notifier"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  test do
    assert_match version.to_s, pipe_output("#{bin}/terminal-notifier -help")
  end
end
