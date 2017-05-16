class VampPluginSdk < Formula
  desc "audio processing plugin system sdk"
  homepage "http://www.vamp-plugins.org"
<<<<<<< HEAD
  head "https://code.soundsoftware.ac.uk/hg/vamp-plugin-sdk", :using => :hg

  stable do
    url "https://code.soundsoftware.ac.uk/attachments/download/1520/vamp-plugin-sdk-2.6.tar.gz"
    sha256 "d0d3578137ac0c1e63f31561081a8d61da526a81152bc1dc9383b629bc07f85f"
    # activate osx specific items in Makefile.in
    # https://code.soundsoftware.ac.uk/issues/1473
    patch :p1, :DATA
  end

  bottle do
    cellar :any
    sha256 "3a2e87cfd4ba5c0eb9675ad4a0cb2fd412315bd71f81cde9d5fd0648bafdd08c" => :sierra
    sha256 "3c1665b45ed9060ddcc00036b760e48e2d8f884877a8976bfb5d5bb8b8dc09b0" => :el_capitan
    sha256 "9f9faa350b6a0072264107506a243cc627459da143e41b1cde8af2cad1b52079" => :yosemite
    sha256 "86a5d017be8bccf01f43b6e99fb2f441bde4dc6edff36837d58467926563e4f7" => :mavericks
=======
  url "https://code.soundsoftware.ac.uk/attachments/download/2206/vamp-plugin-sdk-2.7.1.tar.gz"
  sha256 "c6fef3ff79d2bf9575ce4ce4f200cbf219cbe0a21cfbad5750e86ff8ae53cb0b"
  head "https://code.soundsoftware.ac.uk/hg/vamp-plugin-sdk", :using => :hg

  bottle do
    cellar :any
    sha256 "f5b77eaf0b80183cf7c19b08c4734b49393ad38e382da03666a8c8a3b5063b5d" => :sierra
    sha256 "acd0d2d514e459907217d67a6a2652bce37e6b87564fc9383a1e22763b84472a" => :el_capitan
    sha256 "ada7d84cbd975d1857e83651815a8a3a465ee04299fd32e5d90eba6646d6325c" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "automake" => :build
  depends_on "pkg-config" => :build
  depends_on "libsndfile"
  depends_on "libogg"
  depends_on "flac"

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include "vamp-sdk/Plugin.h"
      #include <vamp-sdk/PluginAdapter.h>

      class MyPlugin : public Vamp::Plugin { };

      const VampPluginDescriptor *
      vampGetPluginDescriptor(unsigned int version, unsigned int index) { return NULL; }
    EOS

    system ENV.cxx, "test.cpp", "-I#{include}", "-Wl,-dylib", "-o", "test.dylib"
    assert_match /Usage:/, shell_output("#{bin}/vamp-rdf-template-generator 2>&1", 2)

    cp "#{lib}/vamp/vamp-example-plugins.so", testpath/"vamp-example-plugins.dylib"
    ENV["VAMP_PATH"]=testpath
    assert_match /amplitudefollower/, shell_output("#{bin}/vamp-simple-host -l")
  end
end
<<<<<<< HEAD

__END__
diff -r 1522e2f6d700 -r 3bfc44d26963 Makefile.in
--- a/Makefile.in	Fri Sep 04 13:48:28 2015 +0100
+++ b/Makefile.in	Fri Dec 11 12:59:21 2015 +0000
@@ -104,16 +104,32 @@
 PLUGIN_LDFLAGS		= $(DYNAMIC_LDFLAGS) -Wl,--version-script=build/vamp-plugin.map


-## For OS/X with g++:
-#DYNAMIC_LDFLAGS		= -dynamiclib
-#PLUGIN_LDFLAGS			= $(DYNAMIC_LDFLAGS)
-#SDK_DYNAMIC_LDFLAGS		= $(DYNAMIC_LDFLAGS)
-#HOSTSDK_DYNAMIC_LDFLAGS	= $(DYNAMIC_LDFLAGS)
+# Adapt install details when found to be running on OSX (thanks to David O)
+uname_S = $(shell uname -s)
+ifeq ($(uname_S),Darwin)
+
+	DYNAMIC_LDFLAGS		  = -dynamiclib
+	SDK_DYNAMIC_LDFLAGS	  = $(DYNAMIC_LDFLAGS)
+	HOSTSDK_DYNAMIC_LDFLAGS	  = $(DYNAMIC_LDFLAGS)
+	PLUGIN_LDFLAGS		  = $(DYNAMIC_LDFLAGS) -exported_symbols_list build/vamp-plugin.list
+
+	INSTALL_HOSTSDK_LIBNAME   = libvamp-hostsdk.3.6.0.dylib
+	INSTALL_HOSTSDK_LINK_ABI  = libvamp-hostsdk.3.dylib
+
+# The OS X linker doesn't allow you to request static linkage when
+# linking by library search path, if the same library name is found in
+# both static and dynamic versions. So if we install both static and
+# dynamic, the static library will never be used. That's OK for the
+# host SDK, but we do want plugins to get static linkage of the plugin
+# SDK. So install the dynamic version under a different name.
+	INSTALL_SDK_LIBNAME	  = libvamp-sdk-dynamic.2.6.0.dylib
+	INSTALL_SDK_LINK_ABI	  = libvamp-sdk-dynamic.2.dylib
+
+endif


 ### End of user-serviceable parts

-
 API_HEADERS	= \
		$(APIDIR)/vamp.h

diff -r 1522e2f6d700 -r 3bfc44d26963 build/update-version.sh
--- a/build/update-version.sh	Fri Sep 04 13:48:28 2015 +0100
+++ b/build/update-version.sh	Fri Dec 11 12:59:21 2015 +0000
@@ -42,6 +42,12 @@
 $p 's/(INSTALL_SDK_LINK_ABI\s*=\s*libvamp-sdk.so).*/$1.'$sdkmajor'/' \
     Makefile.in

+$p 's/(INSTALL_SDK_LIBNAME\s*=\s*libvamp-sdk-dynamic).*.dylib/$1.'$sdkmajor'.'$sdkminor'.0.dylib/' \
+    Makefile.in
+
+$p 's/(INSTALL_SDK_LINK_ABI\s*=\s*libvamp-sdk-dynamic).*.dylib/$1.'$sdkmajor'.dylib/' \
+    Makefile.in
+
 $p 's/(current)=.*/$1='$sdkmajor'/' \
     build/libvamp-sdk.la.in

@@ -54,6 +60,12 @@
 $p 's/(INSTALL_HOSTSDK_LINK_ABI\s*=\s*libvamp-hostsdk.so).*/$1.'$hostmajor'/' \
     Makefile.in

+$p 's/(INSTALL_HOSTSDK_LIBNAME\s*=\s*libvamp-hostsdk).*.dylib/$1.'$hostmajor'.'$hostminor'.0.dylib/' \
+    Makefile.in
+
+$p 's/(INSTALL_HOSTSDK_LINK_ABI\s*=\s*libvamp-hostsdk).*.dylib/$1.'$hostmajor'.dylib/' \
+    Makefile.in
+
 $p 's/(current)=.*/$1='$hostmajor'/' \
     build/libvamp-hostsdk.la.in

diff -r 1522e2f6d700 -r 3bfc44d26963 configure
--- a/configure	Fri Sep 04 13:48:28 2015 +0100
+++ b/configure	Fri Dec 11 12:59:21 2015 +0000
@@ -1,6 +1,6 @@
 #! /bin/sh
 # Guess values for system-dependent variables and create Makefiles.
-# Generated by GNU Autoconf 2.69 for vamp-plugin-sdk 2.5.
+# Generated by GNU Autoconf 2.69 for vamp-plugin-sdk 2.6.
 #
 # Report bugs to <cannam@all-day-breakfast.com>.
 #
@@ -580,8 +580,8 @@
 # Identity of this package.
 PACKAGE_NAME='vamp-plugin-sdk'
 PACKAGE_TARNAME='vamp-plugin-sdk'
-PACKAGE_VERSION='2.5'
-PACKAGE_STRING='vamp-plugin-sdk 2.5'
+PACKAGE_VERSION='2.6'
+PACKAGE_STRING='vamp-plugin-sdk 2.6'
 PACKAGE_BUGREPORT='cannam@all-day-breakfast.com'
 PACKAGE_URL=''

@@ -1243,7 +1243,7 @@
   # Omit some internal or obsolete options to make the list less imposing.
   # This message is too long to be a string in the A/UX 3.1 sh.
   cat <<_ACEOF
-\`configure' configures vamp-plugin-sdk 2.5 to adapt to many kinds of systems.
+\`configure' configures vamp-plugin-sdk 2.6 to adapt to many kinds of systems.

 Usage: $0 [OPTION]... [VAR=VALUE]...

@@ -1304,7 +1304,7 @@

 if test -n "$ac_init_help"; then
   case $ac_init_help in
-     short | recursive ) echo "Configuration of vamp-plugin-sdk 2.5:";;
+     short | recursive ) echo "Configuration of vamp-plugin-sdk 2.6:";;
    esac
   cat <<\_ACEOF

@@ -1402,7 +1402,7 @@
 test -n "$ac_init_help" && exit $ac_status
 if $ac_init_version; then
   cat <<\_ACEOF
-vamp-plugin-sdk configure 2.5
+vamp-plugin-sdk configure 2.6
 generated by GNU Autoconf 2.69

 Copyright (C) 2012 Free Software Foundation, Inc.
@@ -1651,7 +1651,7 @@
 This file contains any messages produced by compilers while
 running configure, to aid debugging if configure makes a mistake.

-It was created by vamp-plugin-sdk $as_me 2.5, which was
+It was created by vamp-plugin-sdk $as_me 2.6, which was
 generated by GNU Autoconf 2.69.  Invocation command line was

   $ $0 $@
@@ -4505,7 +4505,7 @@
 # report actual input values of CONFIG_FILES etc. instead of their
 # values after options handling.
 ac_log="
-This file was extended by vamp-plugin-sdk $as_me 2.5, which was
+This file was extended by vamp-plugin-sdk $as_me 2.6, which was
 generated by GNU Autoconf 2.69.  Invocation command line was

   CONFIG_FILES    = $CONFIG_FILES
@@ -4558,7 +4558,7 @@
 cat >>$CONFIG_STATUS <<_ACEOF || ac_write_fail=1
 ac_cs_config="`$as_echo "$ac_configure_args" | sed 's/^ //; s/[\\""\`\$]/\\\\&/g'`"
 ac_cs_version="\\
-vamp-plugin-sdk config.status 2.5
+vamp-plugin-sdk config.status 2.6
 configured by $0, generated by GNU Autoconf 2.69,
   with options \\"\$ac_cs_config\\"
=======
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
