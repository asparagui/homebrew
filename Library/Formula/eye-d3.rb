require 'formula'

class EyeD3 < Formula
  homepage 'http://eyed3.nicfit.net/'
  url 'http://eyed3.nicfit.net/releases/eyeD3-0.7.1.tgz'
  sha1 '6f67346845af42c03448f25e8b524449f1170b51'

  def install
    man1.install "doc/eyeD3.1.in" => "eyeD3.1"

    # Manually process this file
    inreplace "src/eyeD3/__init__.py.in" do |s|
      s.change_make_var! "eyeD3Version", "\"#{version}\""
      s.change_make_var! "eyeD3Maintainer", "\"Pacakaged by Homebrew\""
    end
    mv "src/eyeD3/__init__.py.in", "src/eyeD3/__init__.py"

    libexec.install "src/eyeD3"
    libexec.install "bin/eyeD3" => "eyeD3_script"
    bin.install_symlink libexec+"eyeD3_script", "eyeD3"
  end
end
