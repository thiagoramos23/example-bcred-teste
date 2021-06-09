defmodule Proposals.Core.ProponentTest do
  use ExUnit.Case, async: false
  alias Proposals.Core.Proponent

  @fields %{id: 1, name: "Marcus", age: 20, monthly_income: 3000, main: true}

  def base_proponent(params \\ %{}) do
    new_params = 
      params
      |> Enum.into(@fields)

    Map.merge(%Proposals.Core.Proponent{}, new_params)
  end

  test "new\1 creates a proposal" do
    assert base_proponent == Proposals.Core.Proponent.new(@fields)
  end

  test "valid?\1 valid if proponent is older than 18 years old" do
    invalid_proponent = base_proponent(%{age: 17})
    valid_proponent   = base_proponent(%{age: 18})

    refute Proponent.valid?(invalid_proponent) == true
    assert Proponent.valid?(valid_proponent)   == true
  end
end
