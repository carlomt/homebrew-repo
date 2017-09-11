# Documentation: https://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class FlairGeoviewer < Formula
  desc ""
  homepage ""
  desc "Geoviewer for Flair"
  homepage "http://www.fluka.org/flair/"
  head "http://svn.cern.ch/guest/flair/tags/release/geoviewer", :using => :svn
  url "http://www.fluka.org/flair/flair-geoviewer-2.2-1.tgz"
  version "2.2-1"
  sha256 "bf55f38e9ce088b2342a246c22d158f99bc1e21a008f31ee5e964bc54a697d3c"
  url "http://www.fluka.org/flair/flair-geoviewer-2.3-0.tgz"
  version "2.3-0"
  sha256 "dced59cb0da8a58eef91bf94a2c7812ca81a9344af79bea267421e78870e2723"

  # depends_on "flair"

  def install
    ENV.deparallelize  # if your formula fails when building in parallel
    
    system "make"
    system "make install DESTDIR=#{prefix}"
  end
  
  def post_install
    destdir = Formula["flair"].prefix
    # destdir = "/usr/local/lib/"
    
    # if build.with? "HEAD"
    #   destdir = "#{destdir}/../HEAD"
    #   system "echo #{destdir}"
    # end
    
    ln_s prefix/"geoviewer.so", destdir
    ln_s prefix/"usrbin2dvh", destdir
    ln_s prefix/"fonts", destdir

    # bin.install_symlink "geoviewer.so"
    # bin.install_symlink "usrbin2dvh"
    # bin.install_symlink "fonts"
  end
  
end
