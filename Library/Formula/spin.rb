require 'formula'

class Spin < Formula
  homepage 'http://spinroot.com/spin/whatispin.html'
  url 'http://spinroot.com/spin/Src/spin622.tar.gz'
  version '6.2.2'
  sha1 'f402048864761d0fceefa61e8f03a9ee33a16a4c'

  fails_with :llvm do
    build 2334
  end

  def install
    ENV.deparallelize

    cd("Src#{version}") do
      system "make"
      bin.install "spin"
    end

    man1.install "Man/spin.1"
  end
end
