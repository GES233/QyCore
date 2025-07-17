defprotocol QyCore.Param.Validator do
  @moduledoc """
  参数序列的检测。
  """

  @fallback_to_any true

  @spec validate(any()) :: :ok | {:error, term()}
  def validate(raw_data)
end

defimpl QyCore.Param.Validator, for: Any do
  def validate(_), do: :ok
end
