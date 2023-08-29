#!/bin/bash -ex

mix ecto.migrate
exec mix phx.server
