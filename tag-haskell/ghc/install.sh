#!/bin/sh

resolver=lts-12.16

stack --resolver="${resolver}" setup

stack --resolver="${resolver}" install \
	ipprint-0.6 \
	sr-extra-1.46.3.2 \
	Unixutils-1.54.1 \
	goa-3.3 \
	hoogle
hoogle generate

PATH="$PATH:$(stack --resolver="${resolver}" path --bin-path)" \
	cabal install lambdabot
