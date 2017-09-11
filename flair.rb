class Flair < Formula
  desc "Flair - FLUKA Advanced Interface"
  homepage "http://www.fluka.org/flair/"
  head "http://svn.cern.ch/guest/flair/tags/release/flair", :using => :svn
  # url "http://www.fluka.org/flair/flair-2.2-1.tgz"
  # version "2.2-1"
  # sha256  "963d7cb1935bd626767459f5c0765e590653a2d23eea81ff5f9b9aabcc1a1916"
  url "http://www.fluka.org/flair/flair-2.3-0.tgz"
  version "2.3-0"
  sha256 "ea39f49f7e63ee4739f284be35c28777e0cd7f5c4a0408d96ec9ca9d55e22be9"

  option "with-pydicom", "add the pydicom package to brewed python" 
  option "with-Pillow", "add the Pillow package to brewed python" 
  option "with-aquaterm", "add aquaterm to gnuplot"
  option "with-wxmac", "add wxmac to gnuplot"
  
  # depends_on "cmake" => :build
  depends_on :x11    
  depends_on "freetype"
  if build.with? "with-aquaterm" and build.with? "with-wxmac"
    depends_on "gnuplot" => ["with-wxmac","with-x11","with-aquaterm"]
  elsif build.with? "with-wxmac"
    depends_on "gnuplot" => ["with-wxmac","with-x11"]
  elsif build.with? "with-aquaterm"
    depends_on "gnuplot" => ["with-x11","with-aquaterm"]
  elsif
    depends_on "gnuplot" => "with-x11"
  end
  depends_on "gnuplot"
  depends_on "carlomt/repo/tcl-tk"
  # depends_on "homebrew/dupes/tcl-tk" => ["with-threads", "with-x11"]
  depends_on "python" => "with-tcl-tk"
  depends_on "numpy" => :python

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    if build.with? "with-pydicom"
      system "pip install numpy"
      system "pip install pydicom"
    end

    if build.with? "with-Pillow"
      system "pip install Pillow"
    end

    bin.install Dir["#{libexec}/bin/*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
    
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
        # Adapted by:   Carlo.Mancini.Terracciano@roma1.infn.it
        # Date:	1-Jul-2016

      EOS
    line = "DIR=\"#{prefix}/\" \n"
    target.write(line)
    target.write <<-EOS.undent
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
    
    # geoviewerdir = Formula["flair-geoviewer"].prefix
    # geoviewerdir = "/usr/local/lib/"
    
    # ln_s geoviewerdir/"geoviewer.so", prefix
    # ln_s geoviewerdir/"usrbin2dvh", prefix
    # ln_s geoviewerdir/"fonts", prefix
    
    # end
      
  end
  
 # def caveats; <<-EOS.undent
 #    Homebrew writes wrapper scripts that set PYTHONPATH in ansible's
 #    execution environment, which is inherited by Python scripts invoked
 #    by ansible. If this causes problems, you can modify your playbooks
 #    to invoke python with -E, which causes python to ignore PYTHONPATH.
 #    EOS
 #  end

  
end
