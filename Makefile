all: build install

build:
	gem build alm.gemspec

install:
	gem install alm-0.1.0.gem
