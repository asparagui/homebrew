require "formula"

class Openlitespeed < Formula
  homepage "http://open.litespeedtech.com/mediawiki/"
  url "http://open.litespeedtech.com/packages/openlitespeed-1.3.10.tgz"
  sha1 "4a409b65cacc3ee5e2855ab213a5f3e9858a8003"
  head "https://github.com/litespeedtech/openlitespeed.git"

  option "with-debug", 'Compile with support for debug log'
  option "with-spdy", 'Compile with support for SPDY module'

  depends_on "pcre"
  depends_on "geoip"
  # SPDY needs openssl >= 1.0.1 for NPN; see:
  # https://tools.ietf.org/agenda/82/slides/tls-3.pdf
  # http://www.openssl.org/news/changelog.html
  depends_on "openssl" if build.with? 'spdy'

  def install
    args = ["--disable-dependency-tracking", "--prefix=#{prefix}"]
    args << "--enable-debug" if build.with? 'debug'
    args << "--enable-spdy" if build.with? 'spdy'
    args << "--with-openssl=#{Formula["openssl"].opt_prefix}" if build.with? 'spdy'
    system "./configure", *args
    system "make", "install"
  end
end
