defmodule QyCore.Param.Metadata do
  @moduledoc """
  `QyCore.Param` 的元数据。
  """

  @type param_source :: :default | :model_generated | :manual_override | :mixed | :derived
  @type recipe_name :: atom() | module()
  @type extra_meta :: %{recipe_name() => any()}

  @type t :: %__MODULE__{}
  defstruct [
    :create_at,
    source: :default
  ]
end
