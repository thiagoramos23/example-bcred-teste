defmodule Proposals.Core.Warranty do
  defstruct [:id, :value, :province]

  def new(fields) do
    struct!(__MODULE__, fields)
  end

  def valid?(warranty) do
    result = 
      invalid_provinces()
      |> Enum.member?(warranty.province)

    !result
  end

  defp invalid_provinces do
    ["SC", "PR", "RS"]
  end
end
