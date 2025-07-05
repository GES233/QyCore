defmodule QyCore.Repo.EtsAdapter do
  # 虽然 http://elixir-lang.org/getting-started/mix-otp/ets.html
  # 提到确定需要使用 ETS 缓存前需要对整个系统的瓶颈进行分析，但是用
  # ass 想都知道，QyCore 涉及到动辄几千组甚至单个对象在内存中占据兆字节
  # 的大规模数据的存取，还真算得上是——瓶颈（类似于计算过程时的 CPU
  # 密集任务的性能瓶颈和我无关哈）。

  # @behaviour QyCore.Repo

  # use GenServer

  # @ets_table_name :qy_param_repo_mem

  # 1. Implement function to initalize Repo via its name
  # (the name can be modified)

  # def start_link/1

  # @impl QyCore.Repo
  # def ready(args), do: apply(__MODULE__, :start_link, args)
end
