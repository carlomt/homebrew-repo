# homebrew-repo

## Homebrew

Brew is a package manager for OSX made with simply Ruby scripts
its features, usage and installation instructions are [summarized on its homepage][brew].

This repository is just a collection of formulae I developed to easily install some tools.
These tools are downloaded directly from the developers websites.
To use this repository type:

`brew tap carlomt/repo`


## Flair

[Flair] is an interface for [FLUKA].
To install the stable version of flair (with the geoviewer module) type:
brew install flair-geoviewer
if you want to install the HEAD version you have to manually install the two packages:

`brew install --HEAD flair`

`brew install --HEAD flair-geoviewer`

`ln -s /usr/local/Cellar/flair-geoviewer/HEAD/geoviewer.so  /usr/local/Cellar/flair/HEAD/`

`ln -s /usr/local/Cellar/flair-geoviewer/HEAD/usrbin2dvh  /usr/local/Cellar/flair/HEAD/`

`ln -s /usr/local/Cellar/flair-geoviewer/HEAD/fonts  /usr/local/Cellar/flair/HEAD/`


## pydicom
It is still a not working test. Install it with:
`pip install pydicom`
or with the option `--pydicom` of the flair formula.


[brew]:http://brew.sh
[Flair]:http://www.fluka.org/flair/index.html
[FLUKA]:http://fluka.org/