defmodule QyCore.Runner.CookingContext do
  @moduledoc """
  承载运行时的上下文。
  """

  @type t :: %__MODULE__{
          recipe: QyCore.Recipe.t(),
          recipe_options: any(),
          param_maps: param_maps(),
          instruments: instruments(),
          repos: repos()
        }
  defstruct [
    :recipe,
    # 这里的 options 是全局的
    :recipe_options,
    :param_maps,
    :instruments,
    :repos
  ]

  @type param_maps :: %{atom() => QyCore.Param.t()}

  @type instruments :: %{atom() => QyCore.Instrument.t()}

  @type repos :: %{QyCore.Repo.repo_name() => pid()}
end
