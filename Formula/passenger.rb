class Passenger < Formula
  desc "Server for Ruby, Python, and Node.js apps via Apache/NGINX"
  homepage "https://www.phusionpassenger.com/"
<<<<<<< HEAD
  url "https://s3.amazonaws.com/phusion-passenger/releases/passenger-5.1.2.tar.gz"
  sha256 "7fb03a54650ef5e508895c9e45bc2d8151f6c4811ea6797e81f017fedddfdbab"
  head "https://github.com/phusion/passenger.git"

  bottle do
    sha256 "ca278f0cd952a92b13766640a650cb0cd82f1893ad3c83c840e9a923b0693abd" => :sierra
    sha256 "7b337e44ba1ed6d64f1347949b03dc3ae455f931af14a932ad3226000fcea2f0" => :el_capitan
    sha256 "3f7d9b91caddaaf2b63877b7340afe64140f21d59b95f75f7933f081edc21123" => :yosemite
=======
  url "https://s3.amazonaws.com/phusion-passenger/releases/passenger-5.1.4.tar.gz"
  sha256 "6e8460143fff88c7ae833b43ff5389c0b0d2654ee38ab1ac62e24a3814416de0"
  head "https://github.com/phusion/passenger.git"

  bottle do
    sha256 "255c52aabadb3967c64531f475e39c2f3e08ea3068c33f12ea83de44d2c95a7b" => :sierra
    sha256 "102517e493951ae2a5563c04e38f453f7f7445bbf32af0c08ede3af8c9307211" => :el_capitan
    sha256 "02351f07430761f124fd1f99df283dde6921e21e514e6f11be25d4f40700a260" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  option "without-apache2-module", "Disable Apache2 module"

  depends_on :macos => :lion
  depends_on "pcre"
  depends_on "openssl"
<<<<<<< HEAD
  depends_on "apr-util"
=======
>>>>>>> kettle: fix hardcoded /usr/local idiocy.

  def install
    # https://github.com/Homebrew/homebrew-core/pull/1046
    ENV.delete("SDKROOT")

<<<<<<< HEAD
    ENV["APU_CONFIG"] = Formula["apr-util"].opt_bin/"apu-1-config"
    ENV["APR_CONFIG"] = Formula["apr"].opt_bin/"apr-1-config"

=======
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
    inreplace "src/ruby_supportlib/phusion_passenger/platform_info/openssl.rb" do |s|
      s.gsub! "-I/usr/local/opt/openssl/include", "-I#{Formula["openssl"].opt_include}"
      s.gsub! "-L/usr/local/opt/openssl/lib", "-L#{Formula["openssl"].opt_lib}"
    end
<<<<<<< HEAD
    inreplace "src/ruby_supportlib/phusion_passenger/config/nginx_engine_compiler.rb",
      "http://nginx.org",
      "https://nginx.org"
=======
>>>>>>> kettle: fix hardcoded /usr/local idiocy.

    rake "apache2" if build.with? "apache2-module"
    rake "nginx"

<<<<<<< HEAD
    system("/usr/bin/ruby ./bin/passenger-config compile-nginx-engine")

=======
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
    (libexec/"download_cache").mkpath

    # Fixes https://github.com/phusion/passenger/issues/1288
    rm_rf "buildout/libev"
    rm_rf "buildout/libuv"
    rm_rf "buildout/cache"

    necessary_files = Dir[".editorconfig", "configure", "Rakefile", "README.md", "CONTRIBUTORS",
      "CONTRIBUTING.md", "LICENSE", "CHANGELOG", "INSTALL.md",
      "passenger.gemspec", "build", "bin", "doc", "man", "dev", "src",
      "resources", "buildout"]
    libexec.mkpath
    cp_r necessary_files, libexec, :preserve => true

    # Allow Homebrew to create symlinks for the Phusion Passenger commands.
    bin.install_symlink Dir["#{libexec}/bin/*"]

    # Ensure that the Phusion Passenger commands can always find their library
    # files.

    locations_ini = `/usr/bin/ruby ./bin/passenger-config --make-locations-ini --for-native-packaging-method=homebrew`
    locations_ini.gsub!(/=#{Regexp.escape Dir.pwd}/, "=#{libexec}")
    (libexec/"src/ruby_supportlib/phusion_passenger/locations.ini").write(locations_ini)

    ruby_libdir = `/usr/bin/ruby ./bin/passenger-config about ruby-libdir`.strip
    ruby_libdir.gsub!(/^#{Regexp.escape Dir.pwd}/, libexec)
    system "/usr/bin/ruby", "./dev/install_scripts_bootstrap_code.rb",
      "--ruby", ruby_libdir, *Dir[libexec/"bin/*"]

<<<<<<< HEAD
=======
    system("/usr/bin/ruby ./bin/passenger-config compile-nginx-engine")
    cp Dir["buildout/support-binaries/nginx*"], libexec/"buildout/support-binaries", :preserve => true

>>>>>>> kettle: fix hardcoded /usr/local idiocy.
    nginx_addon_dir = `/usr/bin/ruby ./bin/passenger-config about nginx-addon-dir`.strip
    nginx_addon_dir.gsub!(/^#{Regexp.escape Dir.pwd}/, libexec)
    system "/usr/bin/ruby", "./dev/install_scripts_bootstrap_code.rb",
      "--nginx-module-config", libexec/"bin", "#{nginx_addon_dir}/config"

    mv libexec/"man", share
  end

  def caveats
    s = <<-EOS.undent
      To activate Phusion Passenger for Nginx, run:
        brew install nginx --with-passenger

      EOS

    s += <<-EOS.undent if build.with? "apache2-module"
      To activate Phusion Passenger for Apache, create /etc/apache2/other/passenger.conf:
        LoadModule passenger_module #{opt_libexec}/buildout/apache2/mod_passenger.so
        PassengerRoot #{opt_libexec}/src/ruby_supportlib/phusion_passenger/locations.ini
        PassengerDefaultRuby /usr/bin/ruby

      EOS
    s
  end

  test do
    ruby_libdir = `#{HOMEBREW_PREFIX}/bin/passenger-config --ruby-libdir`.strip
    assert_equal "#{libexec}/src/ruby_supportlib", ruby_libdir
  end
end
