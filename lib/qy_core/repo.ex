defmodule QyCore.Repo do
  @type refkey :: any()
  @type data :: any()

  @callback init(any()) :: pid()

  @callback get(refkey()) :: {:ok, data()} | {:error, term()}

  @callback put(data()) :: {:ok, refkey()} | {:error, term()}
end
