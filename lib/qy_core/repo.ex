defmodule QyCore.Repo do
  @moduledoc "定义大容量数据的仓库（可以有多种实现）。"

  @type repo_id :: pid()
  @type refkey :: any()
  @type data :: any()

  @callback ready(any()) :: pid() | no_return()

  @callback get(repo_id(), refkey()) :: {:ok, data()} | {:error, term()}

  @callback put(repo_id(), data()) :: {:ok, refkey()} | {:error, term()}

  @callback delete(repo_id(), refkey()) :: :ok | {:error, term()}

  def __using__(_opts) do
    quote do
      @behaviour __MODULE__

      # 因为一般这里的 Repo 实现是一个 OTP 模块，所以直接调用其 start_link/1 即可
      def ready(args), do: apply(unquote(__MODULE__), :start_link, args)

      defoverridable ready: 1

      # 如果 opts 中有名字的话，将名字注册到 @repo_name 属性
      # 但是如果不用 pid 的话，这里需不需要一个 RepoRegistry ？
    end
  end
end
