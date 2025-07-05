defmodule QyCore.Recipe.Step do
  @moduledoc """
  `QyCore.Recipe.Step` 是 `QyCore.Recipe` 中执行数据转换和操作的基本单元。

  每个 `QyCore.Recipe.Step` 都封装了一个特定的、原子化的、单一的职责，例如数据格式转换、模型推理、数据校正或决策逻辑。

  其 `Step` 的名称正好是相对于 `Recipe` 里的一步。

  ## 实现自己的 `QyCore.Recipe.Step`

  虽然 `QyCore.Recipe.Step` 的灵感来源于 Elixir 生态中非常重要的 [`Plug`](https://hexdocs.pm/plug) 。

  ### 作为模块

  TBD

  ### 作为函数

  TBD

  ## 使用 Step

  参见 `t:t/0` 。
  """

  @type data :: any() | tuple()
  @type options :: any()

  # 单一量可以省略吗？
  # e.g. {foo} => foo
  @type input_keys :: atom() | tuple()
  @type output_keys :: atom() | tuple()

  # 将 input_keys/output_keys 与 step 模块/函数分开的原因在于其输入输出的具体名字更多的用于 Recipe 的调度
  @type module_step ::
          {module(), input_keys: input_keys(), output_keys: output_keys(), opts: options()}
  @type function_step ::
          {(data(), options() -> data()),
           input_keys: input_keys(), output_keys: output_keys(), opts: options()}

  @type t :: module_step() | function_step()

  @callback init(options()) :: options()

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
