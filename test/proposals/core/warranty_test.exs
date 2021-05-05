defmodule Proposals.Core.WarrantyTest do
  use ExUnit.Case, async: false

  alias Proposals.Core.Warranty

  @fields %{id: 1, value: 200000, province: "SP"}

  def warranty(params \\ %{}) do
    new_params = 
      params
      |> Enum.into(@fields)

    Map.merge(%Warranty{}, new_params)
  end

  test "new/1 creates a warranty" do
    base_warranty = warranty()
    assert base_warranty == Warranty.new(@fields)
  end

  test "valid?/1 PR, SC, and RS provinces are not acceptable in the warranty" do
    base_warranty = warranty()
    pr_province_warranty = warranty(%{province: "PR"})
    sc_province_warranty = warranty(%{province: "SC"})
    rs_province_warranty = warranty(%{province: "RS"})

    assert Warranty.valid?(base_warranty)        == true
    refute Warranty.valid?(pr_province_warranty) == true
    refute Warranty.valid?(sc_province_warranty) == true
    refute Warranty.valid?(rs_province_warranty) == true
  end
end


