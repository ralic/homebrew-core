class Menhir < Formula
  desc "LR(1) parser generator for the OCaml programming language"
  homepage "http://cristal.inria.fr/~fpottier/menhir"
<<<<<<< HEAD
  url "http://cristal.inria.fr/~fpottier/menhir/menhir-20170418.tar.gz"
  sha256 "31deadeef2129ffcbdd78717007e13f87031432e6c3601f7e829bb0e5f9c7d2b"

  bottle do
    sha256 "86157755557dd51f1a9322adc8327807be6ccb7fdf4a4ea451d9c177f7f9e78e" => :sierra
    sha256 "c279ad81a33a688861afe7c9a32d6dd98ec404d4bec00cb0e563e7a3356a8c5a" => :el_capitan
    sha256 "b169d89422b88a6121f56f1d1d4d25fa1990b6ed5b89577a328ceb5406d6178a" => :yosemite
=======
  url "http://cristal.inria.fr/~fpottier/menhir/menhir-20170509.tar.gz"
  sha256 "36a690856f972adaadcff0138380b563f92041aab9d5dcaf29da1c27c8326baa"

  bottle do
    sha256 "941ac6971cc025ec64855fbc30b72dc23ec1af2095185a7653e5749dabc5ddd7" => :sierra
    sha256 "83ec68613aa79950aa71e5b36b41d31f226e058737726f5de8a71b8cda9519c6" => :el_capitan
    sha256 "acf20752b6ca88cf359ac7ec81606ca10d9c3c730862ac837af62ede0a08709b" => :yosemite
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  end

  depends_on "ocamlbuild" => :build
  depends_on "ocaml"

  def install
    system "make", "PREFIX=#{prefix}", "all"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    (testpath/"test.mly").write <<-EOS.undent
      %token PLUS TIMES EOF
      %left PLUS
      %left TIMES
      %token<int> INT
      %start<int> prog
      %%

      prog: x=exp EOF { x }

      exp: x = INT { x }
      |    lhs = exp; op = op; rhs = exp  { op lhs rhs }

      %inline op: PLUS { fun x y -> x + y }
                | TIMES { fun x y -> x * y }
    EOS

    system "#{bin}/menhir", "--dump", "--explain", "--infer", "test.mly"
    assert File.exist? "test.ml"
    assert File.exist? "test.mli"
  end
end
