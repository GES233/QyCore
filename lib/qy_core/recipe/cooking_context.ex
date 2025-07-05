defmodule QyCore.Recipe.CookingContext do
  @moduledoc "运行上下文"

  @type t :: %__MODULE__{
          recipe: any(),
          options: any(),
          param_maps: param_maps()
        }
  defstruct [
    :recipe,
    :options,
    :param_maps
  ]

  @type param_maps :: %{any() => QyCore.Param.t()}
end
