require "formula"

class Libgit2 < Formula
  homepage "http://libgit2.github.com/"
  url "https://github.com/libgit2/libgit2/archive/v0.21.2.tar.gz"
  sha1 "a16a59df1bfe073483be0c58a81cdbc89f7b7070"

  head "https://github.com/libgit2/libgit2.git", :branch => "development"

  bottle do
    cellar :any
    revision 1
    sha1 "264ee00fbd0df428ac1de74ae7d74f98d8109066" => :yosemite
    sha1 "809e858db9e378949989b23b045b527a34af3b12" => :mavericks
    sha1 "d833de5afde015cf8905fbf070083023cc1d9201" => :mountain_lion
  end

  depends_on "cmake" => :build
  depends_on "libssh2" => :optional
  depends_on "openssl"

  def install
    mkdir "build" do
      system "cmake", "..",
                      "-DBUILD_TESTS=NO",
                      *std_cmake_args
      system "make install"
    end
  end
end
