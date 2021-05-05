defmodule Proposals.Core.Proponent do
  defstruct [:id, :name, :age, :monthly_income, main: false]

  def new(fields) do
    struct!(__MODULE__, fields)
  end

  def valid?(proponent) do
    proponent
    |> valid_age?
  end

  defp valid_age?(proponent) do
    proponent.age >= 18
  end
end
