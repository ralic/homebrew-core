require "language/go"

class GitlabCiMultiRunner < Formula
  desc "The official GitLab CI runner written in Go"
  homepage "https://gitlab.com/gitlab-org/gitlab-ci-multi-runner"
  url "https://gitlab.com/gitlab-org/gitlab-ci-multi-runner.git",
<<<<<<< HEAD
      :tag => "v9.1.0",
      :revision => "0118d891c7ec1a0ff9e92fae57b02780fac75a7b"
=======
      :tag => "v9.1.1",
      :revision => "61043251ea9d53f98c2155ad3e69203f5bf99008"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://gitlab.com/gitlab-org/gitlab-ci-multi-runner.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "edd1762bc189c83fb80b60fd2b5d33715f7a3d46f53c826a61d3710e740a1639" => :sierra
    sha256 "dfe5a523f0b5d1e9413ede20160c21d3a9daa1a73146f9363a6d650b5dfa7188" => :el_capitan
    sha256 "985d92f7eb0fd71a650e144c38caac86931824152bd90199edc55e8f8e82ea5e" => :yosemite
=======
    sha256 "83149437b880cd1250f8714dbcec6f854c9a0f0a67f058d9742417e79ef5422a" => :sierra
    sha256 "db9c84f49d0b1b3ad8edfaadba2cb4d80828fcc8a3d864342945958b9ead677d" => :el_capitan
    sha256 "5587d9d9383bd7212be234cec20884fb67aefaee62aed254f15d33be3397e36c" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "go" => :build
  depends_on "docker" => :recommended

  go_resource "github.com/jteeuwen/go-bindata" do
    url "https://github.com/jteeuwen/go-bindata.git",
        :revision => "a0ff2567cfb70903282db057e799fd826784d41d"
  end

  resource "prebuilt-x86_64.tar.xz" do
<<<<<<< HEAD
    url "https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/v9.1.0/docker/prebuilt-x86_64.tar.xz",
        :using => :nounzip
    version "9.1.0"
    sha256 "b9fa9dfd1b50b327c51c720a5e5eaf587e207a1d213fb0c170f67957cae1acd5"
  end

  resource "prebuilt-arm.tar.xz" do
    url "https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/v9.1.0/docker/prebuilt-arm.tar.xz",
        :using => :nounzip
    version "9.1.0"
    sha256 "e6c97f7748f104a30cf439221dcc12635f22ae6fd751992103ae0f0f6935b7d4"
=======
    url "https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/v9.1.1/docker/prebuilt-x86_64.tar.xz",
        :using => :nounzip
    version "9.1.1"
    sha256 "8c233cca69c018892cdfd6b62c8effc996b8e4378a6f33c85b6a10770f32bbb3"
  end

  resource "prebuilt-arm.tar.xz" do
    url "https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/v9.1.1/docker/prebuilt-arm.tar.xz",
        :using => :nounzip
    version "9.1.1"
    sha256 "3fbb8b0761df3b7a6e2cfeb4768d6425c1e0ed56cc85e3ca80b372c618c5a656"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  def install
    ENV["GOPATH"] = buildpath
    dir = buildpath/"src/gitlab.com/gitlab-org/gitlab-ci-multi-runner"
    dir.install buildpath.children
    ENV.prepend_create_path "PATH", buildpath/"bin"
    Language::Go.stage_deps resources, buildpath/"src"

    cd "src/github.com/jteeuwen/go-bindata/go-bindata" do
      system "go", "install"
    end

    cd dir do
      Pathname.pwd.install resource("prebuilt-x86_64.tar.xz"),
                           resource("prebuilt-arm.tar.xz")
      system "go-bindata", "-pkg", "docker", "-nocompress", "-nomemcopy",
                           "-nometadata", "-o",
                           "#{dir}/executors/docker/bindata.go",
                           "prebuilt-x86_64.tar.xz",
                           "prebuilt-arm.tar.xz"

      proj = "gitlab.com/gitlab-org/gitlab-ci-multi-runner"
      commit = Utils.popen_read("git", "rev-parse", "--short", "HEAD").chomp
      branch = version.to_s.split(".")[0..1].join("-") + "-stable"
      built = Time.new.strftime("%Y-%m-%dT%H:%M:%S%:z")
      system "go", "build", "-ldflags", <<-EOS.undent
             -X #{proj}/common.NAME=gitlab-ci-multi-runner
             -X #{proj}/common.VERSION=#{version}
             -X #{proj}/common.REVISION=#{commit}
             -X #{proj}/common.BRANCH=#{branch}
             -X #{proj}/common.BUILT=#{built}
      EOS

      bin.install "gitlab-ci-multi-runner"
      bin.install_symlink bin/"gitlab-ci-multi-runner" => "gitlab-runner"
      prefix.install_metafiles
    end
  end

  plist_options :manual => "gitlab-ci-multi-runner start"

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>SessionCreate</key><false/>
        <key>KeepAlive</key><true/>
        <key>RunAtLoad</key><true/>
        <key>Disabled</key><false/>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/gitlab-ci-multi-runner</string>
          <string>run</string>
          <string>--working-directory</string>
          <string>#{ENV["HOME"]}</string>
          <string>--config</string>
          <string>#{ENV["HOME"]}/.gitlab-runner/config.toml</string>
          <string>--service</string>
          <string>gitlab-runner</string>
          <string>--syslog</string>
        </array>
      </dict>
    </plist>
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gitlab-runner --version")
  end
end
