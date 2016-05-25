class Flair < Formula
  desc "Flair - FLUKA Advanced Interface"
  homepage "http://www.fluka.org/flair/"
  head "http://svn.cern.ch/guest/flair/tags/release/flair", :using => :svn
  url "http://www.fluka.org/flair/flair-2.2-1.tgz"
  version "2.2-1"
  sha256  "963d7cb1935bd626767459f5c0765e590653a2d23eea81ff5f9b9aabcc1a1916"

  option "pydicom", "add the pydicom package to brewed python" 
  
  depends_on :x11 
  depends_on "gnuplot" => ["with-wxmac","with-x11","with-aquaterm"]
  # depends_on "freetype" => "universal"
  # depends_on "libpng" => "universal"
  depends_on "freetype" #  => "universal"
  depends_on "gettext"
  depends_on "glib"
  depends_on "pixman"
  depends_on "cairo"
  depends_on "gobject-introspection"
  depends_on "icu4c"
  depends_on "harfbuzz"
  depends_on "pango"
  depends_on "homebrew/dupes/tcl-tk" => ["with-threads", "with-x11"]
  depends_on "python" => "with-tcl-tk"
  depends_on "numpy" => :python
  # depends "pydicom" => [:recommended, :python]
  # depends_on "flair-geoviewer" => :recommended
  
  # resource "pydicom" do
  #   url "https://github.com/darcymason/pydicom/archive/master.zip"
  # end

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # # ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"
    
    # # system "python", *Language::Python.setup_install_args(libexec/"pydicom")
    if build.with? "pydicom"
      system "pip install pydicom"
    end
    #   ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"
    #   system "python", *Language::Python.setup_install_args("pydicom")
    #   # %w[pydicom].each do |r|
    #   #   resource(r).stage do
    #   #     system "python", *Language::Python.setup_install_args(libexec/"vendor")
    #   #   end
    #   # end
    # end
    
    # ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"
    # system "python", *Language::Python.setup_install_args(libexec)

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

 # def caveats; <<-EOS.undent
 #    Homebrew writes wrapper scripts that set PYTHONPATH in ansible's
 #    execution environment, which is inherited by Python scripts invoked
 #    by ansible. If this causes problems, you can modify your playbooks
 #    to invoke python with -E, which causes python to ignore PYTHONPATH.
 #    EOS
 #  end

  
end
