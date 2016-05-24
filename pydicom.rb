class Pydicom < Formula
  desc "a python package for working with DICOM files"
  homepage "https://github.com/darcymason/pydicom"
  url "https://github.com/darcymason/pydicom/archive/master.zip"
  
  depends_on "python"
  depends_on "numpy" => :python
  
  
  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"
    system "python", *Language::Python.setup_install_args(prefix)
  end

  test do
    system python, "-c", "import pydicom"
  end
end
