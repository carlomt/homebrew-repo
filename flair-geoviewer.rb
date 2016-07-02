class FlairGeoviewer < Formula
  desc "Geoviewer for Flair"
  homepage "http://www.fluka.org/flair/"
  head "http://svn.cern.ch/guest/flair/tags/release/geoviewer", :using => :svn
  url "http://www.fluka.org/flair/flair-geoviewer-2.2-1.tgz"
  version "2.2-1"
  sha256 "bf55f38e9ce088b2342a246c22d158f99bc1e21a008f31ee5e964bc54a697d3c"
  
  depends_on "flair"

  def install
    ENV.deparallelize  # if your formula fails when building in parallel
    
    system "make"
    system "make install DESTDIR=#{prefix}"
  end
  
  def post_install
#    destdir = Formula["flair"].prefix
    destdir = "/usr/local/lib/"
    
    # if build.with? "HEAD"
    #   destdir = "#{destdir}/../HEAD"
    #   system "echo #{destdir}"
    # end
    
    # ln_s prefix/"geoviewer.so", destdir
    # ln_s prefix/"usrbin2dvh", destdir
    # ln_s prefix/"fonts", destdir

    bin.install_symlink "geoviewer.so"
    bin.install_symlink "usrbin2dvh"
    bin.install_symlink "fonts"
  end
  
end
