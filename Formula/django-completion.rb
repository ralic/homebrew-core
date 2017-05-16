class DjangoCompletion < Formula
  desc "Bash completion for Django"
  homepage "https://github.com/django/django"
<<<<<<< HEAD
  url "https://github.com/django/django/archive/1.11.tar.gz"
  sha256 "9df049409289682e21f57629ddb5f847aa4cb8acd42c3974a81dcc64644b63f5"
=======
  url "https://github.com/django/django/archive/1.11.1.tar.gz"
  sha256 "98841534054d7e6c24d90cc065b755879706ce65d83ea00a34be675d765edbea"
>>>>>>> kettle: fix hardcoded /usr/local idiocy.
  head "https://github.com/django/django.git"

  bottle :unneeded

  def install
    bash_completion.install "extras/django_bash_completion" => "django"
  end

  test do
    assert_match "-F _django_completion",
      shell_output("source #{bash_completion}/django && complete -p django-admin.py")
  end
end
