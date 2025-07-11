defmodule QyCore.Ingredient do
  @moduledoc """
  管理存在副作用的数据或资源（e.g. ONNX 模型或数据库）的生命周期。

  如果这些已经在 Supervisor 树上了，那么该模块也可以充当简单的封装。
  """

  @type options :: any()

  @type data :: any()

  @typedoc "一般是实现了回调的模块"
  @type t :: module()

  @callback prepare(options()) :: {:ok, data()} | {:has_already, data()} | {:error, term()}

  @callback cleanup(data()) :: :ok | :ignore | {:error, term()}
end
