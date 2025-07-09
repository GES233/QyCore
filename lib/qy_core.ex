defmodule QyCore do
  @moduledoc """
  `QyCore` 提供了一套用于构建和执行复杂数据处理流程的基础设施。

  其设计灵感来源于函数式编程和数据流思想，期望利用 BEAM 的高并发优势以及
  Elixir 无认知负担的语法实现灵活、可组合且高性能的时间序列数据处理平台。

  QyCore 大抵可以分成四个部分：

  * `QyCore.Param` - 数据的表现形式。

  * `QyCore.Repo` - 大容量数据的保存方式/渠道。

  * `QyCore.Recipe` - 定义数据的处理流程。

  * `QyCore.Runner` - 定义运行时需要实现的功能，并且定义了一个简单的适配器。
  """

  @doc """
  Hello world.

  ## Examples

      iex> QyCore.hello()
      :world

  """
  def hello do
    :world
  end
end
