class Cfengine < Formula
  desc "Help manage and understand IT infrastructure"
  homepage "https://cfengine.com/"
<<<<<<< HEAD
  url "https://cfengine-package-repos.s3.amazonaws.com/tarballs/cfengine-3.9.0.tar.gz"
  sha256 "32a38aedf1199c2361e1335e0d4a1d98f9efa7cd591bcb647f35c7395bb66f2d"

  bottle do
    cellar :any
    rebuild 1
    sha256 "9e44968c018b2c768a8e06e56f7a7d2d1055e681c7d5ac15f8965d2ccb88e668" => :sierra
    sha256 "116955921224f5bab1043aec945fec298febb2798758abb559970304b9320bba" => :el_capitan
    sha256 "6519f4ca5364019cd9239db4433c2b8eda6bfbb8e02e25441530b17805b10105" => :yosemite
=======
  url "https://cfengine-package-repos.s3.amazonaws.com/tarballs/cfengine-3.10.1.tar.gz"
  sha256 "0abb7e91d667a4f339b61e105dc66c583fa98e0217c6fc7fcf8a73300badca98"

  bottle do
    sha256 "c20e03c47ec3c2d5e580dbef1b60cdab5619aab548b92904e1fc3f4e20308b74" => :sierra
    sha256 "3146afa8ef4e2c5cedc7861dece69a9dc51f4fb4724b724363a616a600b6045f" => :el_capitan
    sha256 "a3a2527726612948e9ca8e6f82ef5bd6d21c53780b8c618db2c0455b0aa7e19c" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "libxml2" if MacOS.version < :mountain_lion
  depends_on "pcre"
  depends_on "lmdb"
  depends_on "openssl"

  resource "masterfiles" do
<<<<<<< HEAD
    url "https://cfengine-package-repos.s3.amazonaws.com/tarballs/cfengine-masterfiles-3.9.0.tar.gz"
    sha256 "63dec2f8649f5f2788cd463dccf47f8dbe941522acfcf3093517f983bbfa0606"
=======
    url "https://cfengine-package-repos.s3.amazonaws.com/tarballs/cfengine-masterfiles-3.10.1.tar.gz"
    sha256 "c4b0ff856d9af1cc62559b0ca4a7d39548442b13167a294637ed65cd5a811900"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  def install
    # Fix "typedef redefinition with different types"
    if DevelopmentTools.clang_build_version >= 800
      ENV["ac_cv_type_clockid_t"] = "yes"
    end

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-workdir=#{var}/cfengine",
                          "--with-lmdb=#{Formula["lmdb"].opt_prefix}",
                          "--with-pcre=#{Formula["pcre"].opt_prefix}",
                          "--without-mysql",
                          "--without-postgresql"
    system "make", "install"
    (pkgshare/"CoreBase").install resource("masterfiles")
  end

  test do
    assert_equal "CFEngine Core #{version}", shell_output("#{bin}/cf-agent -V").chomp
  end
end
