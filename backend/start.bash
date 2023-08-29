#!/bin/bash -ex

mix deps.get
mix compile
mix assets.deploy
mix ecto.migrate
exec mix phx.server
