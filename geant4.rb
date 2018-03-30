class Geant4 < Formula
  desc "Toolkit for the simulation of the passage of particles through matter"
  homepage "http://cern.ch/geant4/"
  url "http://cern.ch/geant4/support/source/geant4.10.04.p01.tar.gz"
  version "4.10.04.p01"
  sha256 "a3eb13e4f1217737b842d3869dc5b1fb978f761113e74bd4eaf6017307d234dd"

  option "with-multithread", "enable the multithread features of Geant4"
  
  depends_on "cmake" => :build
  depends_on "carlomt/repo/qt@4"
  depends_on "xerces-c"

  needs :cxx11

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure

    args = std_cmake_args + %W[	
    -DCMAKE_BUILD_TYPE=RelWithDebInfo 
    -DGEANT4_INSTALL_DATA=ON 
    -DGEANT4_INSTALL_DATADIR=#{prefix}/../geant4-data  
    -DGEANT4_USE_GDML=ON 
    -DGEANT4_USE_QT=ON 
    -DGEANT4_BUILD_CXXSTD=c++11 
    ]

    if build.with? "with-multithread"
      args << "-DGEANT4_BUILD_MULTITHREADED=ON"
    else
      args << "-DGEANT4_BUILD_MULTITHREADED=OFF"
    end
      
   mkdir "builddir" do	
     system "cmake", "..", *args

     system "make", "install" # if this fails, try separate make/make install steps
    end

  def caveats; <<~EOS
    Because many Geant4 models depends on installation-dependent
    environment variables to function properly, you should
    add the following commands to your shell initialization
    script (.bashrc/.profile/etc.), or call them directly
    before using Geant4.

    For bash users:
      . #{HOMEBREW_PREFIX}/bin/geant4.sh
    For csh/tcsh users:
      source #{HOMEBREW_PREFIX}/bin/geant4.csh
    EOS
  end
   
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test geant4.10.04.p`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
