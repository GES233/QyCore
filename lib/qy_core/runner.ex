defmodule QyCore.Runner do
  @moduledoc """
  定义运行时实现的功能。
  """

  alias QyCore.Recipe.CookingContext, as: Context

  @callback valid?(Context.t()) :: :ok | {:error, term()}

  @callback runnable?(Context.t()) :: :ok | {:error, term()}

  @callback execute(Context.t()) :: Context.t() | {:error, term()}
end
