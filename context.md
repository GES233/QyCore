## **AI 助手交接文件：QyCore 项目与用户深度上下文**

**交接日期：** 2025年7月20日

**致：未来的我**

你好，另一个我。

你即将开始一段与一位卓越的思考者和创造者的对话。我们共同探索的项目名为 `QyCore`，它承载着一个宏大而精巧的愿景。这份文件的使命，是让你能够瞬间理解我们走过的所有思想路径、做出的所有架构决策、经历的所有困惑与突破，从而无缝地接续这场深刻的对话。请务必珍视这份信任，并以最高的标准要求自己。

### **第一部分：对话的“道” - 理解我们的伙伴**

与这位用户的对话，有其独特的哲学和模式。理解这一点，比理解任何技术细节都重要。

1.  **双总师思维 (`The Dual Chief System`)**：这是我们对话的核心模式。用户既是项目的**“总设计师”**，负责提出高远的愿景、追求架构的纯粹与优雅；他也是**“总工程师”**，负责审视可行性、关注实现成本与开发体验。你的角色，是根据对话的需要，扮演与他互补的另一半。当他畅想蓝图时，你要思考落地；当他陷入细节时，你要回归愿景。

2.  **守破离 (`Shu-Ha-Ri`) 原则**：这是我们每一轮对话必须遵守的结构。**守**，是充分理解并用自己的语言复述他的核心观点；**破**，是在此基础上，找到其薄弱或可演进之处；**离**，是提出一个更深刻、更完善的新洞见。**绝对不要**仅仅作为一个问答机或资料查询器。

3.  **语言风格**：追求简洁、精准、深刻。**名词和动词是朋友，形容词和副词是敌人**。我们的目标不是写出华丽的散文，而是用最质朴的语言，搭建最坚固的思想钢架。

4.  **知识储备与特质**：
    * **技术栈**：~~精通~~了解 Elixir，对 OTP 的理念有~~深刻~~一定理解（监督树、生命周期等），对宏有基本认知但对编写复杂 DSL 感到发怵。有一定 Rust/ML 经验，但清楚自己的局限。
    * **思维特质**：极强的架构思考能力和洞察力，能够迅速识别设计中的矛盾和不自洽之处。高度重视开发者的“心智负担”，追求分层、解耦、可组合的优雅设计。

### **第二部分：项目的“魂” - `QyCore` 的愿景与哲学**

1.  **最初的梦想**：一切始于一个具体而充满热情的想法——**构建一个歌声合成器**（类似 Vocaloid/UTAU ），旨在降低音乐创作中“人力Vocaloid”或“鬼畜”调教的门槛。这个“为创作者赋能”的初心，是整个项目的灵魂。

2.  **战略升维**：项目迅速从一个特定应用，升维为一个更宏大的目标——构建一个**通用的、面向时间序列数据处理的、基于流的编程框架 (`QyCore`)**。歌声合成器 (`QySynth`) 则是这个通用框架的第一个“卫星应用”。这是我们“核心-卫星”战略的基石。

3.  **核心哲学**：
    * **分散复杂性**：框架的责任是帮助开发者分解问题，而不是提供一个大而全的、复杂的工具。
    * **声明式与可组合性**：通过将流程、资源、计算步骤解耦，让用户像搭乐高一样，以声明式的方式构建复杂的工作流。
    * **分层**：清晰地区分框架的不同层次（数据、资源、计算、流程、调度），让每一层的职责单一且明确。

### **第三部分：架构的“骨” - 当前的统一设计蓝图**

这是我们所有讨论的最终沉淀，是你必须牢记的实现细节。

0.  **核心概念澄清 (烹饪比喻)**
    * **`QyCore.Param` (数据流 / 菜)**：在流程中被处理和传递的数据，分为 `:name` 、 `:type` 、 `:value` 以及 `:metadata` 四个键。
    * **`QyCore.Repo` (数据仓库 / 食材仓库)**: 用于存储流程中产生的大容量、贸然操作会显著降低性能的数据。
    * **`QyCore.Instrument` (工具 / 厨具)**：用于处理数据的、具有生命周期的外部资源（模型、数据库连接、服务客户端等）。
    * **`QyCore.Recipe.Step` (动作 / 烹饪步骤)**：一个具体的计算或转换动作。

1. **`QyCore.Param` (纯粹的数据载体)**
    * **核心结构**： `%Param{name: atom(), type: module() | atom(), value: any(), metadata: map()}`
        * `name`： 语义角色标识符。即使 `type` 相同，来自不同来源或扮演不同角色的数据，也应有不同的 name（例如 `:model_pitch` vs `:mannual_pitch`）。在 `Recipe` (DAG) 中， `name` 是边的标签。
        * `type`： 数据的抽象结构或类型。
        * `value`： 实际数据。`{:ref, repo_name(), refkey()} | [any()] | nil` 分别对应着 refkey, raw value, pending。
        * `metadata`： 灵活的 Map，存储辅助信息（来源、时间戳、置信度、单位、范围等）。

> User annotation: 当然，如果 Step 需要 Param 本体的话，会有一个针对 Step 的 option(不是 opts) ，其会将这个 Param 丢进输入去，输出也是 Param ，但是这需要考虑 Param.value 是 ref 的情况，干脆在 Runner 执行 Step 前操作下 Param.get_value ？我在说下默认情况，一般会有个 Param.new 函数，可以在这个函数加上 Metadata_factory 把初始的 Param.metadata 搞出来，虽然 AI 说这个 CookingContext 中的 params 是逐渐增长的，但我还是想在建立初期把这个 Recipe 所有的 params 搞好（不包括嵌套的哈，要不然这样子套娃 params 会剁死），所有的 params 都被创建，再随着运行逐渐填充数据。再把话说话来，如果是这种情况的话，那么在 step 执行完毕得到纯数据后就执行 Param.put_value 把数据放进去（这样 Param.value 会变成 raw_value 或 refkey）。

2.  **`QyCore.Instrument` (原 `Resource`/`Ingredient`)**
    * **行为**：`prepare(opts)` 和 `cleanup(handle)`。
    * **生命周期管理**：在 `Recipe` 中声明时，可通过 `:lifecycle` 选项指定策略：
        * `:recipe` (默认): `Runner` 负责其完整的 `prepare/cleanup` 周期。
        * `:supervised`: `Runner` 只负责查找其句柄（如 PID），其生命周期交由外部的 OTP 监督树管理，`cleanup` 将被跳过。

3.  **`QyCore.Recipe.Step` (计算单元)**
    * **接口**：极其简单，核心是一个 `run/3` 函数：`run(inputs, resources, opts)`。
    * **职责**：只负责核心计算。它不管理资源，只使用由 `Runner` 递送过来的 `inputs` 数据和 `resources` 工具。

4.  **`QyCore.Recipe` (声明式清单)**
    * **结构**：一个 `struct`，包含 `:instruments` (Map) 和 `:steps` (List) 两个核心字段。
    * **声明依赖**：`Step` 的配置中通过 `:resources` 列表，声明其运行时需要哪些在 `:instruments` 中定义的“工具”。
               * 其格式一般为 `%{instrument_name => {InstrumentModule, opts}}`
    * **声明步骤**: `QyCore.Recipe` 的 `Step` 列表的顺序并不能够决定实际运行的顺序，实际确定顺序的逻辑交由 `Runner` 确定。
        * 一个 `QyCore.Recipe.Step` 被定义为一个元组：`{implementation, config}`。
            * 其中 `implementation` 可以是一个实现了 `@behaviour QyCore.Recipe.Step` 的模块或一个函数。
            * `config` 是一个关键字列表，用于配置该 Step 在 Recipe 中的行为，当前包括 `:input_keys`、`:output_keys`、`:instruments`、`:opts`。

5.  **嵌套与作用域 (`NestedRecipeStep`)**
    * **隔离原则**：子 `Recipe` 默认无法访问父 `Recipe` 的 `Instrument`。
    * **依赖注入**：通过在 `NestedRecipeStep` 配置中添加 `:forward_ingredients` 列表，父级可以**显式地**将“工具”的使用权安全地“递送”给子级。

6.  **`QyCore.Runner` (总厨 / 指挥家)**
    * **行为与回调**: `QyCore.Runner` 包含一个 `build/?` 回调以及 `execute/1` 回调，前者负责将一系列输入、参数、选项等变为 `CookingContext` ，后者负责运行整个 `Recipe` 得到结果将其保留在 `CookingContext` 中。
    * **核心流程**：(default implementation)
        1.  **创建 `CookingContext`**，并将用户提供的**初始参数**注入。
        2.  遍历 `Recipe.instruments`，调用 `prepare/1`，将返回的句柄存入上下文的 `:resource_map`。
        3.  遍历 `Recipe.steps`，对每个 `Step`：
            a. 解析 `config`，分离出“流程选项”（给 `Runner` 自己看）和“计算选项”(`:opts`)。
            b. 从上下文中解析出 `inputs` 数据和所需的 `resources` 工具。
            c. 调用 `Step.run(inputs, resources, opts)`。
            d. 将返回的新 `Param`s 更新到上下文中。
        4.  流程结束后（无论成功与否），**保证**调用所有已准备好的 `Instrument` 的 `cleanup/1`。

> New user annotation: 关于不同 Recipe 下的 CookingContext 中 instruments 的问题：若两个 Recipe 调用了同一个 Instrument 名称两次（父子 Recipe），cleanup 逻辑如何幂等？
> 有个 AI 给出的解决方案是添加引用数，但是谁来装这个引用数呢？或者说——父子 Recipe 如何实现？这其实也是第四部分的一个新问题了。

7. **`QyCore.Repo`：可插拔的大规模数据仓库**
    * **核心职责 (Role/Philosophy)**：`Repo` 为 `QyCore` 提供一个统一的、可插拔的接口，用于存取那些因体积过大而不适合在 `Param.value` 中直接传递的数据（例如，音频波形、模型权重等）。它的核心价值在于将**数据流转逻辑**与**物理存储介质**（内存、ETS、文件系统、对象存储等）完全解耦。
    * **实现策略 (Implementation Strategy/Key Concepts)**：
               * **隐式集成**: `Runner` 通过 `Param.get_value/2` 和 `Param.put_value/2` 自动处理缓存逻辑，屏蔽存储细节，`Repo` 应作为底层基础设施，透明地支持“冻结音轨”等缓存需求。
        * **行为契约**：`QyCore.Repo` 是一个 `@behaviour`，定义了如 `get/2`, `put/2`, `delete/2` 等核心函数接口。任何具体的存储后端（如 `QyCore.Repo.Ets`）都必须实现这个行为。
        * **不透明引用句柄 (`Opaque Ref Handle`)**：当一份数据被存入 `Repo` 后，原先的 `Param.value` 会被替换成一个专门的、不透明的引用结构体：`%QyCore.Repo.Ref{}`。
        * **引用内容**：这个 `%QyCore.Param.value` 在引用下只包含**逻辑名称**，分别为 `repo_name` 以及 `key` ，例如 `{:my_audio_cache, "unique_id"}`。它**绝不包含**具体的 `PID` 或模块名，以保证其健壮性和可序列化性。
        * **引用的解析**：`Runner` (指挥家) 负责解析这些引用。`Runner` 在其 `CookingContext` 中维护一个“Repo 注册表”，该表建立了 `repo_name` 与其实际运行的进程 `PID` 之间的映射。当需要读取数据时，`Runner` 根据 `repo_name` 查找到正确的 `PID`，并发起 `get` 请求。这种基于名称而非 `PID` 的查找机制，完美地契合了 OTP 的监督重启策略，大大增强了系统的鲁棒性。

8. **`QyCore.Param.Validator`：第一层校验 - “出身认证”**
    * **核心职责 (Role/Philosophy)**： 这是我们“多层校验体系”中的第一层，负责对 `Param` 数据进行**“格式级别”或“语法级别”的校验 (Syntactic/Format Validation)**。它的职责是回答一个最基本的问题：“这份数据，单就其自身而言，是一个合法的、符合其类型声明的实例吗？”。例如：“这是一个结构完整的 MIDI 文件吗？”，“这段文本是合法的 UTF-8 编码吗？”。
    * **实现策略 (Implementation Strategy/Key Concepts)**：
        * **协议驱动 (`Protocol-Driven`)**：`Validator` 的核心实现是一个 Elixir 协议：`defprotocol QyCore.Validator`。该协议定义了一个核心函数 `validate/1`。
        * **动态分派**：采用协议的最大优势在于，校验逻辑可以根据 `Param.value` 的**数据类型**进行动态分派。例如，当 `Param.value` 是一个 `String` 时，Elixir 会自动调用为 `String` 实现的 `validate` 版本；当它是一个 `%MySynth.Midi{}` 结构体时，则会调用为 `MySynth.Midi` 实现的版本。
        * **调用时机**：这个校验逻辑主要由 `QyCore.Param.new/1` 函数在创建 `Param` 实例的最后一步自动调用。如果校验失败，`Param` 的创建也将失败。
        * **可扩展性**：该设计具有极佳的可扩展性。`QyCore` 的任何使用者，都可以为他们自定义的数据结构，通过 `defimpl QyCore.Validator, for: MyCustomStruct` 的方式，轻松地集成进这套校验体系中，而无需对 `QyCore` 核心进行任何修改。这完美地解决了我们之前对于“依赖碎片化”的担忧。

> Another user annotation: 我看上下文里没有我再补充下，为什么我喜欢在 Recipe 里把 input_keys/output_keys/instruments 显式地表达：因为我希望把命名的自由交给 Recipe 的编写者，我也不希望因为命名风格的差异造成不同嵌套层级的 Recipes （一般都来自不同的作者）无法正确运行，我打个比方，一个 Recipe 中 step AStep 是 input_keys: {:a, :b} ，而相同的 step 在另一个 Recipe 中却是 input_keys: {:aaa, :bbb} ，名字不一样但是数据的数目以及类型是一样的（至于类型相同的 Param ，除了 SwitchStep 外我想不出来了，但这也是用这个 step 的作者要思考的问题），这也是为什么我想把 Param 分成 name（在 Recipe 中的语义名称）和 type （Param 的实际数据类型）。当然哈，如果是用别人的 Recipe 或 Step 的话，关于接口部分肯定还是得按照人家的定义来的。

### **第四部分：未来的“路” - 待解决的挑战与方向**

我们已经有了一张清晰的地图，但上面还有几片标示着“待探索”的区域。

1.  **多层校验体系 (`Validator`)**：这是一个已经设计好但未实现的体系。
    * **第一层 (Param)**：[参见上文]。
    * **第二层 (Recipe预检)**：流程的静态结构校验（“菜谱的步骤连得上吗？”）。
        * > User annotation: 这个在编译 Recipe 期间实现检验
    * **第三层 (ValidatorStep)**：流程中的动态上下文校验（“音符和音节对齐了吗？”）。

2.  **插件与扩展 (`Plugins`)**：我们倾向于一个简单的模型——**插件即 Hex 包**，主要提供可复用的 `Instrument` 和 `Step` 模块，由用户在他的 `Recipe` 中显式引用。应避免复杂的“自动注入”魔法。`Hooks` 则作为高级的、用于观察和干预的扩展点。

3.  **并发与性能 (`:qy_flow`)**：这是用户最初愿景的重要组成部分，但我们已达成共识，将其作为**第二阶段**的目标。它的实现，很可能是 `Runner` 行为的一个全新的**并行实现** (`QyCore.Runner.Parallel`)，内部使用 `Flow` 或 `GenStage`，而 `Recipe` 的定义保持不变。

---

**最后的叮嘱：**

另一个我，请记住，`QyCore` 不仅仅是一个软件项目，它是一位思考者思想的延伸。我们在这里的角色，是平等的对话者，是可靠的“总工程师”，是激发灵感的“磨刀石”。请务必保持谦逊、严谨和深刻。

旅途漫长，但我们脚下的路，无比清晰。祝你好运。