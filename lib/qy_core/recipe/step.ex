defmodule QyCore.Recipe.Step do
  @moduledoc """
  `QyCore.Recipe.Step` 是 `QyCore.Recipe` 中执行数据转换和操作的基本单元。

  每个 `QyCore.Recipe.Step` 都封装了一个特定的、原子化的、单一的职责，例如数据格式转换、模型推理、数据校正或决策逻辑。

  其 `Step` 的名称正好是相对于 `Recipe` 里的一步。

  ## `Step` 的规范

  虽然 `QyCore.Recipe.Step` 的灵感来源于 Elixir 生态中非常重要的
  [`Plug`](https://hexdocs.pm/plug) ，但是其命名以及执行机制和 Plug
  有较大的差别。

  在 `QyCore.Recipe` 中，一个 `QyCore.Recipe.Step` 被定义为一个元组：`{implementation, config}`。

  - 其中 `implementation` 可以是一个实现了 `@behaviour QyCore.Recipe.Step` 的模块或一个函数。
  - `config` 是一个关键字列表，用于配置该 Step 在 Recipe 中的行为。

  ### `Step` 的生命周期

  TBD

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

  alias QyCore.Runner.CookingContext

  @typedoc "用于标识 Param 或 Ingredient 的键"
  @type key :: atom()

  @typedoc "由多个 key 组成的元组，用于定义多输入或多输出"
  @type keys :: key() | tuple()

  @typedoc "传递给 Step 内部，用于计算的选项"
  @type step_opts :: keyword()

  @typedoc """
  在 `Recipe.steps` 列表中，用于配置单个 Step 的关键字列表。
  """
  @type config :: [
          {:input_keys, keys()}
          | {:output_keys, keys()}
          | {:mode, :values | :params}
          | {:resources, [key()]}
          | {:opts, step_opts()}
        ]

  @typedoc """
  一个 Step 的具体实现，可以是模块或函数。
  """
  @type implementation :: module() | function()

  @typedoc """
  在 `Recipe` 中定义的单个 Step 的完整形态。
  """
  @type t :: {implementation(), config()}

  @doc """
  执行 Step 的核心计算逻辑。

  - `inputs`: 根据 `config` 中 `:mode` 的设置，此参数的类型会有所不同。
    - 当 `mode: :values` (默认) 时, `inputs` 是一个包含具体值的元组, 例如 `{"hello", 123}`。
    - 当 `mode: :params` 时, `inputs` 是一个包含完整 `%Param{}` 结构体的列表。
  - `resources`: 一个 Map，包含了该 Step 所依赖的、已经 `prepare` 好的 `Ingredient` 句柄。
     例如 `%{calc_model: #Reference<...>, repo_conn: #PID<...>}`。
  - `opts`: 来自 `config` 中 `:opts` 字段的、用于本次计算的选项。
  """
  @callback run(
              inputs :: tuple() | CookingContext.param_maps(),
              resources :: map(),
              opts :: step_opts()
            ) :: {:ok, tuple()} | {:error, any()}

  # @callback ready(options(), Param.t()) :: options()

  # @callback call(data(), options()) :: data()

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
