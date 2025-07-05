defmodule QyCore.Repo do
  @moduledoc "定义大容量数据的仓库（可以有多种实现）。"

  @type repo_id :: pid()
  @type refkey :: any()
  @type data :: any()

  # @callback ready(any()) :: pid()
  # 虽然一般实际上是
  # def ready(args), do: apply(unquote(__MODULE__), :start_link, args)

  @callback get(repo_id(), refkey()) :: {:ok, data()} | {:error, term()}

  @callback put(repo_id(), data()) :: {:ok, refkey()} | {:error, term()}

  @callback delete(repo_id(), refkey()) :: :ok
end
