defmodule QyCore.Recipe.Step do
  @moduledoc """
  `QyCore.Recipe.Step` 是 `QyCore.Recipe` 中执行数据转换和操作的基本单元。

  每个 `QyCore.Recipe.Step` 都封装了一个特定的、原子化的、单一的职责，例如数据格式转换、模型推理、数据校正或决策逻辑。

  其 `Step` 的名称正好是相对于 `Recipe` 里的一步。

  ## `Step` 的规范

  虽然 `QyCore.Recipe.Step` 的灵感来源于 Elixir 生态中非常重要的
  [`Plug`](https://hexdocs.pm/plug) ，但是其命名以及执行机制和 Plug
  有较大的差别。

  ### `Step` 的生命周期

  执行一个 `Step` 分成两步：

  * 参数的预处理 - 输入为全局的选项，对其进行处理得到运算可能需要的选项（具体逻辑由 Step
  编写者编写的回调、QyCore 的规范以及钩子决定）。

  * 数据的处理 - 输入为数据本体以及处理后的选项，经过计算得到结果。

  一般来讲，Step 本身处理的数据并非 Param 。除非额外设置。

  ### 用于 Step 的选项

  ### 钩子

  * `__after_call_success__`
  * `__after_call_failuer__`

  ## 实现自己的 `QyCore.Recipe.Step`

  ### 作为模块

  TBD

  ### 作为函数

  TBD

  ## 使用 Step

  参见 `t:t/0` 。
  """

  alias QyCore.{Param, Recipe}

  @typedoc "Step 处理的数据本体"
  @type data :: any() | tuple()
  # 这个 options 要有几个特点：
  # 读取简易、可以插入新值
  # 所以没法照搬 Plug 的 t:opts/0
  @typedoc "用于 Step 的选项类型"
  @type options :: tuple() | map() | list() | struct() | MapSet.t()

  # 仅有一个值的话可以以原子形式保存
  @typedoc "输入数据的语义名称组成的元组"
  @type input_keys :: atom() | tuple()
  @typedoc "输出数据的语义名称组成的元组"
  @type output_keys :: atom() | tuple()

  @type module_step ::
          {module(), input_keys: input_keys(), output_keys: output_keys(), opts: options()}
  @type function_step ::
          {(data(), options() -> data()),
           input_keys: input_keys(), output_keys: output_keys(), opts: options()}
  # 稍微提一嘴：这里的执行过程是把 param 本体丢到 ready/2 的 options 里
  # 因为如果数据本体容量很大，再处理来还得复制几份…

  @typedoc """
  Step 所包括的类型。

  将 `input_keys/output_keys` 与 step 分开的原因在于其输入输出的具体名字更多的用于 `QyCore.Recipe` 的调度。
  """
  @type t :: module_step() | function_step() | Recipe.as_step()

  @callback ready(options(), Param.t()) :: options()

  @callback call(data(), options()) :: data()

  # @callback hooks() :: %{atom() => function()}

  # def hooks(), do: %{}
  # defoverridable hooks: 0

  @doc """
  ### Examples

      iex> defmodule MyStep do
      ...>   use QyCore.Recipe.Step
      ...>   @impl true
      ...>   def call(input, _opts), do: input * 2
      ...> end
  """
  defmacro __using__(_opts) do
    quote do
      # Basic part.
      @behavoir unquote(__MODULE__)

      def init(opts), do: opts
      defoverridable init: 1

      # TODO: hooks
    end
  end

  # @spec exec(t(), data()) :: {:ok, data()} | {:error, term()}
  def exec(_step, input) when is_tuple(input) do
    # ...
  end
end
