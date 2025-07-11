defmodule QyCore.Runner do
  @moduledoc """
  定义运行时实现的功能。
  """

  alias QyCore.Param
  alias QyCore.Runner.CookingContext, as: Context

  @callback valid?(Context.t()) :: :ok | {:error, term()}

  @callback runnable?(Context.t()) :: :ok | {:error, term()}

  @callback param_unwrap(Param.t(), unwrap_option :: :param | :data) :: Param.t() | any()

  # TODO: ensure spec
  @callback param_wrap(any() | Param.t(), extra :: any()) :: Param.t()

  @callback execute(Context.t()) :: Context.t() | {:error, term()}
end
