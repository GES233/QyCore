defmodule QyCore.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # 主要就是 QyCore.Repo 了
    children = []

    opts = [strategy: :one_for_one, name: QyCore.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
