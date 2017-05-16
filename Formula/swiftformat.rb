class Swiftformat < Formula
  desc "Formatting tool for reformatting Swift code"
  homepage "https://github.com/nicklockwood/SwiftFormat"
<<<<<<< HEAD
  url "https://github.com/nicklockwood/SwiftFormat/archive/0.28.4.tar.gz"
  sha256 "499f63be9498c632338866f5abf5dfba51dfe155c177ba32679fc0ef72aa96ae"
=======
  url "https://github.com/nicklockwood/SwiftFormat/archive/0.28.5.tar.gz"
  sha256 "c1f42d4409e37861a95f0b3c6b82a66a297e16c5521f50d17fa45e037e32778a"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.

  head "https://github.com/nicklockwood/SwiftFormat.git", :shallow => false

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "9c4a7e4c702adfd186a17f5f5d87c335c7e427f3eaa8c1e29f044b8aa0d909ba" => :sierra
    sha256 "0ca371c77995137e30d8f9c0bff102eb4bfc3cb7d6d6b9150011b6775bd68fa8" => :el_capitan
=======
    sha256 "e321607eb0b7f52b270417d4bea595dfcdd86d81fd90fb36c966c4da1fda4c02" => :sierra
    sha256 "8cca54c9aedd251aec4078e7cdd6f051f7d09d9e4ea4d4d371645549c486b6a6" => :el_capitan
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on :xcode => ["8.0", :build]

  def install
    xcodebuild "-project",
        "SwiftFormat.xcodeproj",
        "-scheme", "SwiftFormat (Command Line Tool)",
        "CODE_SIGN_IDENTITY=",
        "SYMROOT=build", "OBJROOT=build"
    bin.install "build/Release/swiftformat"
  end

  test do
    (testpath/"potato.swift").write <<-EOS.undent
      struct Potato {
        let baked: Bool
      }
    EOS
    system "#{bin}/swiftformat", "#{testpath}/potato.swift"
  end
end
