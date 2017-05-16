class Citus < Formula
  desc "PostgreSQL-based distributed RDBMS"
  homepage "https://www.citusdata.com"
<<<<<<< HEAD
  url "https://github.com/citusdata/citus/archive/v6.1.0.tar.gz"
  sha256 "68a0db12b3ccc639e79cd19e60c0787f62b6cfccda8fa31b6a78522a9f66512a"
=======
  url "https://github.com/citusdata/citus/archive/v6.1.1.tar.gz"
  sha256 "01a887d7f7cf2a7f597e3e76f89ee0ee40a6ec213695309ce893d53a9f3da89f"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/citusdata/citus.git"

  bottle do
    cellar :any
<<<<<<< HEAD
    sha256 "0a5df9927e6975c03abee7ca49d4853a0977f77d117ad1fc5e97c804891f4625" => :sierra
    sha256 "6f6345a929607605c5dea7b2725b69d5f68a124d96291ec94c2f470efd35cb7c" => :el_capitan
    sha256 "17eca2f1b0bb377193b89a6ac6df621c9a25281b027f7c3500dfe157a9ada460" => :yosemite
=======
    sha256 "79aac061c59dc14047737e99c29a91094012c73bd95e635f6bf2a6f7fcd24859" => :sierra
    sha256 "072439852bcae716802370979644f6c767ddc15825ef7f1a8cb28137a2900eb9" => :el_capitan
    sha256 "346ac0fd390c6921f189fa8de568e7f5fa889d259744a67375133bdb3daf37ca" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "postgresql"
  depends_on "readline"

  def install
    ENV["PG_CONFIG"] = Formula["postgresql"].opt_bin/"pg_config"

    system "./configure"

    # workaround for https://github.com/Homebrew/homebrew/issues/49948
    system "make", "libpq=-L#{Formula["postgresql"].opt_lib} -lpq"

    # Use stage directory to prevent installing to pg_config-defined dirs,
    # which would not be within this package's Cellar.
    mkdir "stage"
    system "make", "install", "DESTDIR=#{buildpath}/stage"

    bin.install Dir["stage/**/bin/*"]
    lib.install Dir["stage/**/lib/*"]
    include.install Dir["stage/**/include/*"]
    (share/"postgresql/extension").install Dir["stage/**/share/postgresql/extension/*"]
  end

  test do
    pg_bin = Formula["postgresql"].opt_bin
    pg_port = "55561"
    system "#{pg_bin}/initdb", testpath/"test"
    pid = fork do
      exec("#{pg_bin}/postgres",
           "-D", testpath/"test",
           "-c", "shared_preload_libraries=citus",
           "-p", pg_port)
    end

    begin
      sleep 2

      count_workers_query = "SELECT COUNT(*) FROM master_get_active_worker_nodes();"

      system "#{pg_bin}/createdb", "-p", pg_port, "test"
      system "#{pg_bin}/psql", "-p", pg_port, "-d", "test", "--command", "CREATE EXTENSION citus;"

      assert_equal "0", shell_output("#{pg_bin}/psql -p #{pg_port} -d test -Atc" \
                                     "'#{count_workers_query}'").strip
    ensure
      Process.kill 9, pid
      Process.wait pid
    end
  end
end
