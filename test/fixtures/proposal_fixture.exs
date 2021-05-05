defmodule Fixtures.ProposalFixture do
  alias Proposals.Core.{Proposal, Proponent, Warranty}

  @fields %{id: 1, loan_value: 30000, number_of_monthly_installments: 24}
  @proponent_fields %{id: 1, name: "Carlos", age: 25, monthly_income: 4000, main: false}
  @warranty_fields %{id: 1, value: 200000, province: "SP"}

  def proposal_with_no_proponents_or_warranties(params) do
    proposal = base_proposal(params)
    %{proposal | proponents: [], warranties: []}
  end

  def valid_proposal(params \\ %{}) do
    base_proposal(params)
  end

  def valid_proposal_with_no_proponents(params \\ %{}) do
    proposal = base_proposal(params)
    %{proposal | proponents: []}
  end

  def valid_proposal_with_no_warranties(params \\ %{}) do
    new_params = 
      params
      |> Enum.into(%{warranties: []})
    proposal = base_proposal(params)
    %{proposal | warranties: []}
  end

  def add_proponent(proposal, params \\ %{}) do
    new_params = 
      params
      |> Enum.into(@proponent_fields)

    proponent = Map.merge(%Proponent{}, new_params)
    %{proposal | proponents: [proponent | proposal.proponents]}
  end

  def add_main_proponent(proposal, params \\ %{}) do
    new_params = 
      params
      |> Enum.into(%{main: true})
    add_proponent(proposal, new_params)
  end

  def add_warranty(proposal, params \\ %{}) do
    new_params = 
      params
      |> Enum.into(@warranty_fields)
    warranty = Map.merge(%Warranty{}, new_params) 
    %{proposal | warranties: [warranty | proposal.warranties]}
  end

  defp base_proponent(proposal, params \\ %{}) do
    new_params = 
      params
      |> Enum.into(@proponent_fields)

    Map.merge(%Proponent{}, new_params)
  end

  defp base_proposal(params \\ %{}) do
    new_params = 
      params
      |> Enum.into(@fields)

    proponents = default_proponents()
    warranties = default_warranties()

    proposal = Map.merge(%Proposal{}, new_params)
    %{proposal | proponents: proponents, warranties: warranties}
  end

  defp default_proponents do
    [
      %Proponent{name: "Carlos", age: 25, monthly_income: 5000, main: false},
      %Proponent{name: "Ana", age: 32, monthly_income: 8000, main: true},
    ]
  end

  defp default_warranties do
    [
      %Warranty{value: 200000, province: "SP"}
    ]
  end
end
