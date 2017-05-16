class Ne < Formula
  desc "The nice editor"
  homepage "http://ne.di.unimi.it"
<<<<<<< HEAD
  url "http://ne.di.unimi.it/ne-3.0.1.tar.gz"
  sha256 "92b646dd2ba64052e62deaa4239373821050a03e1b7d09d203ce04f2adfbd0e4"

  bottle do
    cellar :any_skip_relocation
    sha256 "40cdbd64e9afa63534e2c4c9fcf768351eaf8aea1b1d9d301ec5b9188cac2ebd" => :sierra
    sha256 "56d04a63498270ddfed02081ab5970bcc5751a45468ff08b205d639d2e8878ff" => :el_capitan
    sha256 "78875d4f901208279d8d13da35d40d0fbe2278b549a0c33754280f77dcf864e1" => :yosemite
    sha256 "8b7072ee6e35427d7343af22811fb9af854788a14725b4fc6516f6872b273157" => :mavericks
  end

  def install
    system "make"
=======
  url "http://ne.di.unimi.it/ne-3.1.0.tar.gz"
  sha256 "bf2a664e788e4f39073d0000a4ba80f02c43c556cb7fd714704f13175a4b8b51"

  bottle do
    cellar :any_skip_relocation
    sha256 "6cb47aff1c91d22fd98578df10d6c17c1afaa6e493085e453954e540d0dacfa0" => :sierra
    sha256 "b9f8988279a64a070cbadd618d3561b4ef8ed3b4fe3f474b4ea5a1dcbb0f3d2a" => :el_capitan
    sha256 "b5c3a4e39341af06d04d2d233cea0ae56f81d2f1f52ece6ecb9982651794f225" => :yosemite
  end

  def install
    cd "src" do
      system "make"
    end
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    ENV["TERM"] = "xterm"
    document = testpath/"test.txt"
    macros = testpath/"macros"
    document.write <<-EOS.undent
      This is a test document.
    EOS
    macros.write <<-EOS.undent
      GotoLine 2
      InsertString line 2
      InsertLine
      Exit
    EOS
    system "script", "-q", "/dev/null", bin/"ne", "--macro", macros, document
    assert_equal <<-EOS.undent, document.read
      This is a test document.
      line 2
    EOS
  end
end
