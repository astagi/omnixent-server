defmodule OmnixentServerWeb.Resolvers.Content do

  def list_availabilities(_parent, _args, _resolution) do
    {:ok, Omnixent.Core.availability}
  end

end