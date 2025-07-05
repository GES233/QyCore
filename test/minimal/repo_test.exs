defmodule AgentRepo do
  @behaviour QyCore.Repo
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  @impl QyCore.Repo
  def put(repo_pid, key, value) do
    Agent.update(repo_pid, &Map.put(&1, key, value))
    {:ok, key}
  end

  @impl QyCore.Repo
  def get(repo_pid, key) do
    case Agent.get(repo_pid, &Map.get(&1, key)) do
      nil -> {:error, :not_found}
      value -> {:ok, value}
    end
  end

  # @impl QyCore.Repo
  # def delete(repo_pid, key) do
  #   Agent.update(repo_pid, &Map.delete(&1, key))
  #   :ok
  # end
end

defmodule Minimal.RepoTest do
  use ExUnit.Case
end
