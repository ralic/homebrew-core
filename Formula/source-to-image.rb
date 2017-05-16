class SourceToImage < Formula
  desc "Tool for building source and injecting into docker images"
  homepage "https://github.com/openshift/source-to-image"
  url "https://github.com/openshift/source-to-image.git",
<<<<<<< HEAD
    :tag => "v1.1.5",
    :revision => "4dd77215907d810f8fbc9c23dd8c7454f89131eb"
=======
    :tag => "v1.1.6",
    :revision => "f51912980d665f1297bfe0d4ae7f871067c963d7"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/openshift/source-to-image.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "1f22e94321d031311c623ede1d7c8e3640acaab99be7d66fc49232d72a2c00a1" => :sierra
    sha256 "353cf7243ea461e34f10a56c08b8e8b098221c6224bef06527db79c8637789f5" => :el_capitan
    sha256 "8349c19b4d5c583a06736d47f4f00e6f4ed3eecc2aa6de5573699a04a1bcb272" => :yosemite
=======
    sha256 "71a4880319fcdc42d4a5e4883f6bc6df06793ea1a7a654f948757480bd758c9a" => :sierra
    sha256 "3926b5ceef51bbd8f1ed5f3fab153f5e8bc177f6dad3b15191bb18e5e358df88" => :el_capitan
    sha256 "1f485186be20eb7fe3b059cfa974eb49b77eaca92cf1b9fbb93508a9fef554be" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "go" => :build

  def install
    system "hack/build-go.sh"
    bin.install "_output/local/bin/darwin/amd64/s2i"
  end

  test do
    system "#{bin}/s2i", "create", "testimage", testpath
    assert (testpath/"Dockerfile").exist?, "s2i did not create the files."
  end
end
