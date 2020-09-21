#!/bin/sh

elixir -S mix run -e "Omnixent.Mnesia.persist()"
mix phx.server