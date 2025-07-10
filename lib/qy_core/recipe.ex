defmodule QyCore.Recipe do
  @moduledoc """
  `QyCore.Recipe` 定义了数据处理流程。

  ## 构成与职责

  它由一系列 `QyCore.Recipe.Step` 组成，按特定顺序或图结构进行编排，共同完成复杂计算。

  `QyCore.Recipe` 本身不执行具体的数据转换逻辑，而是负责管理 `QyCore.Recipe.Step`
  的执行顺序、处理全局选项的传递，以及协调 `QyCore.Recipe.Step` 之间 `QyCore.Param`
  的输入和输出。

  它支持线性流程以及更复杂的图结构的流程。

  ## 命名规范

  实现 `QyCore.Recipe` 部分暂定统一需要包含
  `QyRecipe.<%= your_recipe_name_with_camel_name %>` 的内容。

  例如：

  * 插件开发
    * `QyRecipe.Curve`
    * `QyRecipe.SourceResolver`
  * 你自己的应用 / 私有插件
    * `YourApp.Port.QyRecipe.YourPersonalRecipe`

  对于其他承载相关逻辑的代码，建议在开发相关插件时使用
  `Qy<%= your_domain %>` 作为模块名，但是没有强制约束。
  """

  alias QyCore.Recipe.Step, as: S

  @type t :: %__MODULE__{}
  defstruct [:steps, :integredient]

  # Add inputs/outputs
  @type as_step :: {module(), any()}

  # 线性 / DAG
  @type steps :: [S.t()] | {[S.t()], :digraph.graph()}
end
