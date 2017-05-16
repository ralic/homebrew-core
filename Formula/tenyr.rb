class Tenyr < Formula
  desc "32-bit computing environment (including simulated CPU)"
  homepage "http://tenyr.info/"
<<<<<<< HEAD
  url "https://github.com/kulp/tenyr/archive/v0.9.3.tar.gz"
  sha256 "62405d084d205c148f6cc4121b7fca817c3fbad5c300e3e137f4a3cb731329bc"

=======
  url "https://github.com/kulp/tenyr/archive/v0.9.4.tar.gz"
  sha256 "15785cf62bbf59bed88cfe1c3f41de63b3fe421695ddd5481ceb9a7a5eea27ff"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/kulp/tenyr.git", :branch => "develop"

  bottle do
    cellar :any
<<<<<<< HEAD
    sha256 "2f79f0c17315ce2c7c6466632d83c5b90806257da76a9faf6cfee133e3e4e0c8" => :sierra
    sha256 "730aada10b54b088a4a48d24c00885a0928b70a7b95b424b6d2bdb2130e5af6d" => :el_capitan
    sha256 "a7f0be7a6661480330e68f655eb67d5e0fe5a1bbd360ad2a2032eba45c595d96" => :yosemite
  end

  # pkg-config is used after v0.9.3 for sdl2, instead of sdl2-config
  # prepare for post-v0.9.3 versions (including HEAD) by depending on it now
=======
    sha256 "75386fda5b5c122eee81f9c1a59a4861e68faa5e64732366af42ecd9eb928c0c" => :sierra
    sha256 "388ee807fdfe7c4bd31676d7a6ad347ee5d35dcc6e48cddc394a2eb739cda80f" => :el_capitan
    sha256 "8273f303c3be52b31f29e047a8bc4f6171f9814a27f7cd14530d944a3e94c932" => :yosemite
  end

>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  depends_on "pkg-config" => :build
  depends_on "bison" => :build # tenyr requires bison >= 2.5
  # sdl2_image implies sdl2. If we specify sdl2 separately, we create
  # nonsensical possibilities like `--with-sdl2_image --without-sdl2`
  # tenyr requires sdl2_image --with-png
  depends_on "sdl2_image" => :recommended

  def install
    bison = Formula["bison"].bin/"bison"

    args = []

    # specify our own bison, since we need bison >= 2.5
    args << "BISON=" + bison

    # JIT build is not available until we can pull in AsmJit somehow
    # HEAD version can build with JIT enabled, using git submodule
    # Right now there is no way for `build.with?("jit")` to be true
    if build.without?("jit")
      args << "JIT=0"
    end

    # Use our own build directory (tenyr's default build directory encodes
    # builder platform information in the path)
    builddir = "build/homebrew"
    args << "BUILDDIR=" + builddir

    if build.without?("sdl2_image")
      args << "SDL=0"
    end

    system "make", *args

    pkgshare.install "rsrc", "plugins"
    cd builddir do
      bin.install "tsim", "tas", "tld"
      lib.install Dir["*.dylib"]
    end
  end

  test do
    # sanity test assembler, linker and simulator
    (testpath/"part1").write "B <- 9\n"
    (testpath/"part2").write "C <- B * 3\n"

    system "#{bin}/tas", "--output=a.to", "part1"
    system "#{bin}/tas", "--output=b.to", "part2"
    system "#{bin}/tld", "--output=test.texe", "a.to", "b.to"

    assert_match "C 0000001b", `tsim -vvvv test.texe`
  end
end
