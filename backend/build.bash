#!/bin/bash -ex

mix deps.get
mix compile
mix assets.deploy
