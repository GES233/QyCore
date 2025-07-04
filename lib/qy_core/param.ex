defmodule QyCore.Param do
  @moduledoc """
  `QyCore.Param` 是数据载体，承载被处理的数据，也是系统中（`QyCore.Recipe.Step`
  之间）所有信息的唯一表示形式。

  ### 大容量数据的保存

  TBD
  """

  alias QyCore.Param, as: P

  @type value :: {:ref, any()} | [any()]

  @type t :: %__MODULE__{
    name: atom(),
    type: atom() | module(),
    value: value(),
    metadata: P.Metadata.t() | map()
  }
  defstruct [
    :name,
    :type,
    :value,
    metadata: %P.Metadata{}
  ]

  def ref?(%P{value: {:ref, _}}), do: true
  def ref?(%P{value: [_ | _]}), do: false
  # Maybe add load or update functions
end
