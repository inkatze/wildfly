SHELL=/usr/bin/env bash

.PHONY: all setup lint

all: setup

setup: lint

lint:
	@pip install --quiet --user -r requirements.txt
	@pre-commit install
