defmodule QyCore.Repo do
  @callback init(any()) :: pid()

  @callback get(any()) :: {:ok, any()} | {:error, term()}

  @callback put(any()) :: {:ok, any()} | {:error, term()}
end
