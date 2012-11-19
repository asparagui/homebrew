require 'formula'

class Skipfish < Formula
  homepage 'http://code.google.com/p/skipfish/'
  url 'http://skipfish.googlecode.com/files/skipfish-2.09b.tgz'
  sha1 'c3c7c561e9e033b96bb7a915b6f6c9a27e8828dd'

  depends_on 'libidn'

  def install
    ENV.append "CFLAGS", "-I#{HOMEBREW_PREFIX}/include"
    ENV.append "LDFLAGS", "-L#{HOMEBREW_PREFIX}/lib"
    
    system 'make'
    bin.install 'skipfish'
    libexec.install %w(assets dictionaries)
  end

  def caveats; <<-EOS.undent
    NOTE: Skipfish uses dictionary-based probes and will not run until
    you have specified a dictionary for it to use. Please read:
      #{libexec}/dictionaries/README-FIRST
    carefully to make the right choice. This step has a profound impact
    on the quality of results later on.

    Use this command to print usage information:
      skipfish -h
    EOS
  end
end
