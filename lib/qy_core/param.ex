defmodule QyCore.Param do
  @moduledoc """
  `QyCore.Param` 是数据载体，承载被处理的数据，也是系统中（`QyCore.Recipe.Step`
  之间）所有信息的唯一表示形式。

  ## 设计原则

  ### `:name` 和 `:type` 的区分

  ### 元数据

  ### 大容量数据的保存

  因为在运行过程中不可避免地存在大量的复制，因此对于大小较大的数据，QyCore
  倾向于将数据本体保存在 `QyCore.Repo` 的某个实现上（TODO: 梳理具体逻辑）而
  `%QyCore.Param{}` 仅保存 refkey 。
  """

  alias QyCore.Param, as: P
  alias QyCore.Repo, as: R

  # 分别对应着 refkey, raw value, pending
  @type value :: {:ref, R.repo_name(), R.refkey()} | [any()] | nil

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

  # 创建
  # new/3
  def new(name, type, metadata_fields \\ []) when is_list(metadata_fields) do
    metadata = for k <- metadata_fields, do: {k, nil} |> Enum.into(%{})

    %__MODULE__{name: name, type: type, value: nil, metadata: metadata}
  end

  # TODO: implement it.
  def new(name, type, metadata_factory, :factory) when is_function(metadata_factory) do
    %__MODULE__{name: name, type: type, value: nil}
  end

  # 针对值本身
  # get_value/2
  # put_value/2

  # 针对元数据
  # get_metadata/2
  # update_metadata/2
  # inject_metadata/2
end
