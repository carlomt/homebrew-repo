class Flair < Formula
  desc "Flair - FLUKA Advanced Interface"
  homepage "http://www.fluka.org/flair/"
  head "http://svn.cern.ch/guest/flair/tags/release/flair", :using => :svn
  url "http://www.fluka.org/flair/flair-2.2-1.tgz"
  version "2.2-1"
  sha256  "963d7cb1935bd626767459f5c0765e590653a2d23eea81ff5f9b9aabcc1a1916"
  
  # depends_on "cmake" => :build
  depends_on :x11 
  depends_on "gnuplot" => ["with-wxmac","with-x11","with-aquaterm"]
  depends_on "freetype"
  #depends_on "gcc" => :optional
  #depends_on "ghostscript"
  #depends_on "homebrew/x11/gv"
  depends_on "homebrew/dupes/tcl-tk" => ["with-threads", "with-x11"]
  depends_on "python" => "with-tcl-tk"
  depends_on "numpy" => :python
  depends_on "pydicom" => :python  => :optional
  # depends_on "flair-geoviewer" => :recommended
  
  def install
    ENV.deparallelize  # if your formula fails when building in parallel
    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"
    
    system "python", *Language::Python.setup_install_args(libexec/"numpy")
    
    system "make", "install-bin", "DESTDIR=#{prefix}", "BINDIR=#{prefix}/bin/"
    prefix.install Dir["*"]

    #("#{prefix}/bin/flair").unlink
    target = open("#{prefix}/bin/flair",'w')
#    ("#{prefix}/bin/myflair")
    target.write <<-EOS.undent
        #!/bin/sh
        # $Id: flair,v 1.26 2011/10/12 07:44:51 bnv Exp $
        #
        # shell script to launch the program
        #
        # Author:	Vasilis.Vlachoudis@cern.ch
        # Date:	13-Jun-2006
        #
        # brewed version


        DIR="/usr/local/Cellar/flair/2.2-1"
        PYTHONPATH=${DIR}/lib
        export PYTHONPATH
        if [ .$PYTHON = . ]; then
	   PYTHON=python
        fi
        CMD="${PYTHON} -W ignore -O ${DIR}/flair.py"
        $CMD $*
      EOS

  end

  def post_install
    
    # bin.install_symlink "#{prefix}/bin/flair"
    # bin.install_symlink "#{prefix}/fless"
    # bin.install_symlink "#{prefix}/fm"
    #    bin.install bin/"flair"

    # if build.with? "flair-geoviewer"

    #   geoviewerdir = Formula["flair-geoviewer"].prefix
      
    #   ln_s geoviewerdir/"geoviewer.so", prefix
    #   ln_s geoviewerdir/"usrbin2dvh", prefix
    #   ln_s geoviewerdir/"fonts", prefix

    # end
      
  end
  
end
