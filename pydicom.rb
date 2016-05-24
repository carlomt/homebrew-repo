class Pydicom < Formula
  desc "A python package for working with DICOM files"
  homepage "https://github.com/darcymason/pydicom"
  url "https://github.com/darcymason/pydicom/archive/v0.9.9.zip"
  version "0.9.9"
  sha256 "e13bbf6db607671d53ff7950c5f1251d638d7224288893f637cf7f830d6f5b85"
  head "https://github.com/darcymason/pydicom.git"
 
  depends_on "python"
  depends_on "numpy" => :python
  
  
  def install
    system "pip install pydicom"
    # ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"
    # system "python", *Language::Python.setup_install_args(prefix/"source")
  end

  test do
    system python, "-c", "import pydicom"
  end
end
