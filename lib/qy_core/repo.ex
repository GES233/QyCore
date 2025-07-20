defmodule QyCore.Repo do
  @moduledoc "定义存储大容量数据的仓库（可以有多种实现）。"

  @typedoc "其他模块/进程可找到该仓库的渠道"
  @type repo_name :: atom() | module()
  @typedoc "用于定位数据的键"
  @type refkey :: any()
  @typedoc "数据本体"
  @type data :: any()

  @callback ready(any()) :: pid() | no_return()

  @callback get(refkey()) :: {:ok, data()} | {:error, term()}

  @callback put(data()) :: {:ok, refkey()} | {:error, term()}

  @callback delete(refkey()) :: :ok | {:error, term()}

  @doc "创建一个新的 refkey"
  @spec gen_refkey() :: refkey()
  def gen_refkey(_current \\ DateTime.now!("Etc/UTC")) do
    # ...
  end

  def __using__(_opts) do
    quote do
      @behaviour __MODULE__

      # 因为一般这里的 Repo 实现是一个 OTP 程序，所以直接调用其 start_link/1 即可
      def ready(args), do: apply(unquote(__MODULE__), :start_link, args)

      defoverridable ready: 1

      # 如果 opts 中有名字的话，将名字注册到 @repo_name 属性
      # 但是如果不用 pid 的话，这里需不需要一个 RepoRegistry ？
    end
  end
end
