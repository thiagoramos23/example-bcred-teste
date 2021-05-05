defmodule Proposals.Core.ProposalTest do
  use ExUnit.Case, async: false

  import Fixtures.ProposalFixture
  alias Proposals.Core.{Proposal, Proponent, Warranty}

  @fields %{id: 1, loan_value: 30000, number_of_monthly_installments: 24}

  test "new/1 creates a proposal" do
    proposal = proposal_with_no_proponents_or_warranties(@fields)
    assert proposal == Proposal.new(@fields)
  end

  test "valid?/1 loan must be between 30k and 3M" do
    invalid_too_low_proposal  = valid_proposal(%{loan_value: 29999})
    invalid_too_high_proposal = valid_proposal(%{loan_value: 29999})
    valid_proposal            = valid_proposal()

    refute Proposal.valid?(invalid_too_low_proposal)  == true
    refute Proposal.valid?(invalid_too_high_proposal) == true
    assert Proposal.valid?(valid_proposal)            == true
  end

  test "valid?/1 monthly installments should be between 24 and 180 months" do
    less_than_minimun_monthns_proposal = valid_proposal(%{number_of_monthly_installments: 23})
    more_than_maximun_monthns_proposal = valid_proposal(%{number_of_monthly_installments: 181})
    valid_proposal                     = valid_proposal()

    assert Proposal.valid?(valid_proposal) == true
    refute Proposal.valid?(less_than_minimun_monthns_proposal) == true
    refute Proposal.valid?(more_than_maximun_monthns_proposal) == true
  end

  test "valid?/1 has at least 2 proponents" do
    valid_proposal = valid_proposal()
    less_than_two_proponents_proposal = valid_proposal_with_no_proponents() |> add_proponent()
    more_than_two_proponents_proposal = 
      valid_proposal_with_no_proponents() 
      |> add_proponent(%{name: "Carlos"})
      |> add_main_proponent(%{name: "Ana"})
      |> add_proponent(%{name: "Maria"})

    assert Proposal.valid?(valid_proposal) == true
    assert Proposal.valid?(more_than_two_proponents_proposal) == true
    refute Proposal.valid?(less_than_two_proponents_proposal) == true
  end

  test "valid?/1 has at least one main proponent" do
    valid_proposal = valid_proposal()
    invalid_proposal_with_no_main_proponent = 
      valid_proposal_with_no_proponents() 
      |> add_proponent(%{name: "Carlos"})
      |> add_proponent(%{name: "Maria"})

    assert Proposal.valid?(valid_proposal) == true
    refute Proposal.valid?(invalid_proposal_with_no_main_proponent) == true
  end

  test "valid?/1 all proponents must be older than 18" do
    valid_proposal = valid_proposal()
    invalid_proposal_with_one_proponent_newer_than_eighteen = 
      valid_proposal_with_no_proponents()
      |> add_proponent(%{name: "Mark", age: 17})
      |> add_proponent(%{name: "John", age: 23})
      |> add_main_proponent(%{name: "Ana"})

    assert Proposal.valid?(valid_proposal) == true
    refute Proposal.valid?(invalid_proposal_with_one_proponent_newer_than_eighteen) == true
  end

  test "valid?/1 proposal should have at least one warranty" do
    valid_proposal = valid_proposal()
    invalid_proposal_no_warranty = valid_proposal_with_no_warranties()

    assert Proposal.valid?(valid_proposal) == true
    refute Proposal.valid?(invalid_proposal_no_warranty) == true
  end

  test "valid?/1 the sum of all warranties must be equal or higher the double of the proposal loan value" do
    valid_proposal = valid_proposal()
    invalid_proposal_warranties_not_double_loan_value = 
      valid_proposal_with_no_warranties(%{loan_value: 100_000})
      |> add_warranty(%{id: 1, value: 100_000})
      |> add_warranty(%{id: 2, value: 80_000})

    assert Proposal.valid?(valid_proposal) == true
    refute Proposal.valid?(invalid_proposal_warranties_not_double_loan_value) == true
  end

  test "valid?/1 PR, SC, and RS provinces are not acceptable in the warranties" do
    valid_proposal = valid_proposal()
    pr_province_warranty = valid_proposal_with_no_warranties() |> add_warranty(%{province: "PR"})
    sc_province_warranty = valid_proposal_with_no_warranties() |> add_warranty(%{province: "SC"})
    rs_province_warranty = valid_proposal_with_no_warranties() |> add_warranty(%{province: "RS"})

    assert Proposal.valid?(valid_proposal)       == true
    refute Proposal.valid?(pr_province_warranty) == true
    refute Proposal.valid?(sc_province_warranty) == true
    refute Proposal.valid?(rs_province_warranty) == true
  end

  describe "Main proponent monthly income should follow the rules" do
    setup [:create_proposal]

    # Loan Value: 100K / Installments: 40 / Monthly Installment: 2.5k
    test "valid?/1 should be 4 times the loan installment for 18 to 24 years old", %{proposal: proposal} do
      valid_proposal = proposal |> add_main_proponent(%{age: 23, monthly_income: 10_000})
      invalid_monthly_income = proposal |> add_main_proponent(%{age: 23, monthly_income: 9_000})

      assert Proposal.valid?(valid_proposal)         == true
      refute Proposal.valid?(invalid_monthly_income) == true
    end

    test "valid?/1 should be 3 times the loan installment for 24 to 50 years old", %{proposal: proposal} do
      valid_proposal = proposal |> add_main_proponent(%{age: 24, monthly_income: 7_500})
      invalid_monthly_income = proposal |> add_main_proponent(%{age: 50, monthly_income: 7_000})

      assert Proposal.valid?(valid_proposal)         == true
      refute Proposal.valid?(invalid_monthly_income) == true
    end

    test "valid?/1 should be 2 times the loan installment for older than 50 years old", %{proposal: proposal} do
      valid_proposal = proposal |> add_main_proponent(%{age: 51, monthly_income: 5_000})
      invalid_monthly_income = proposal |> add_main_proponent(%{age: 51, monthly_income: 4_000})

      assert Proposal.valid?(valid_proposal)         == true
      refute Proposal.valid?(invalid_monthly_income) == true
    end
  end

  defp create_proposal(context) do
    proposal = 
      valid_proposal_with_no_proponents(%{loan_value: 100_000, number_of_monthly_installments: 40}) 
      |> add_proponent()

    {:ok, Map.put(context, :proposal, proposal)}
  end
end
