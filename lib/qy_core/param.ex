defmodule QyCore.Param do
  @moduledoc """
  `QyCore.Param` 是数据载体，承载被处理的数据，也是系统中（`QyCore.Recipe.Step`
  之间）所有信息的唯一表示形式。

  ### 大容量数据的保存

  TBD
  """

  alias QyCore.Param, as: P
  alias QyCore.Repo, as: R

  # 分别对应着 refkey, raw value, pending
  @type value :: {:ref, R.repo_id(), R.refkey()} | [any()] | nil

  @type t :: %__MODULE__{
          name: atom(),
          type: atom() | module(),
          value: value(),
          metadata: P.Metadata.t() | map()
        }
  # @enforce_keys [:name, :type]
  defstruct [
    :name,
    :type,
    :value,
    metadata: %P.Metadata{}
  ]

  def ref?(%P{value: {:ref, _, _}}), do: true
  def ref?(%P{value: [_ | _]}), do: false
  def ref?(%P{value: nil}), do: false

  # 针对值本身
  # get_value/2
  # put_value/2

  # 针对元数据
  # get_metadata/2
  # put_metadata/2
end
