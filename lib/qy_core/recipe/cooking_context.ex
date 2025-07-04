defmodule QyCore.Recipe.CookingContext do
  @moduledoc "运行上下文"

  defstruct []

  @type param_maps :: %{any() => QyCore.Param.t()}
end
