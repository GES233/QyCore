defmodule AgentRepo do
  @behaviour QyCore.Repo
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  @impl true
  def ready(args) do
    args
    |> apply(__MODULE__, :start_link, args)
    |> case do
      {:ok, repo_id} -> repo_id
      {:error, reason} -> raise reason
    end
  end

  @impl true
  def put(repo_id, key, value) do
    Agent.update(repo_id, &Map.put(&1, key, value))
    {:ok, key}
  end

  @impl true
  def get(repo_id, key) do
    case Agent.get(repo_id, &Map.get(&1, key)) do
      nil -> {:error, :not_found}
      value -> {:ok, value}
    end
  end

  @impl true
  def delete(repo_id, key) do
    Agent.update(repo_id, &Map.delete(&1, key))

    :ok
  end
end

defmodule QyCore.RepoTest do
  use ExUnit.Case

  describe "测试用的 AgentRepo 没问题" do
    setup do
      [id: AgentRepo.ready([])]
    end
  end
end
