require 'formula'

class Armitage < Formula
  homepage 'http://www.fastandeasyhacking.com/'
  url 'http://www.fastandeasyhacking.com/download/armitage20130821.tgz'
  sha1 '220e32e16b4bdb664bfeac0cbd0acfe348b5a638'

  depends_on 'metasploit'

  def install
    libexec.install Dir['*.jar']
    bin.write_jar_script libexec/'armitage.jar', 'armitage'
  end

  def caveats; <<-EOS.undent
    Armitage requires a metasploit daemon.
    EOS
  end
end
