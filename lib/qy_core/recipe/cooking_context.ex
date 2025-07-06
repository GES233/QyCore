defmodule QyCore.Recipe.CookingContext do
  @moduledoc "运行上下文"

  @type t :: %__MODULE__{
          recipe: QyCore.Recipe.t(),
          options: any(),
          param_maps: param_maps()
        }
  defstruct [
    :recipe,
    # 这里的 options 是全局的
    :options,
    :param_maps
  ]

  @type param_maps :: %{atom() => QyCore.Param.t()}
end
