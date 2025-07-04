defmodule QyCore.Recipe.Step do
  @moduledoc """
  `QyCore.Recipe.Step` 是 `QyCore.Recipe` 中执行数据转换和操作的基本单元。

  每个 `QyCore.Recipe.Step` 都封装了一个特定的、原子化的、单一的职责，例如数据格式转换、模型推理、数据校正或决策逻辑。

  其 `Step` 的名称正好是相对于 `Recipe` 里的一步。

  ### 实现自己的 `QyCore.Recipe.Step`

  虽然 `QyCore.Recipe.Step` 的灵感来源于 Elixir 生态中非常重要的 [`Plug`](https://hexdocs.pm/plug) ，但和
  Plug 不同的是，因为对于选项处理的复杂程度，目前只允许模块化的 `Step` （函数式待本应用基本完成后再考虑实现）。
  """
  defstruct [
    :input_keys,
    :output_keys,
    :init,
    :call
  ]

  @type data :: any()
  @type options :: any()

  @callback init(options()) :: options()
  @callback call(data(), options()) :: data()
end
