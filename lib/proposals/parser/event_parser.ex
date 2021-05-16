defmodule Proposals.Parser.EventParser do

  alias Proposals.Core.{Proposal, Warranty, Proponent}

  def parse(event, proposals) do
    event_fields = event |> String.trim() |> String.split(",")
    parse_object(proposals, event_fields)
  end

  defp parse_object(proposals, [_, "proposal", "created", _, proposal_id, loan_value, number_of_monthly_installments]) do
    fields = %{id: proposal_id, loan_value: String.to_float(loan_value), number_of_monthly_installments: String.to_integer(number_of_monthly_installments)}
    proposal = Proposal.new(fields)
    [proposal | proposals]
  end

  defp parse_object(proposals, [_, "warranty", "added", _, proposal_id, warranty_id, value, province]) do
    {proposal_index, proposal} = proposal_with_index(proposals, proposal_id)

    proposal = Proposal.add_warranty(proposal, %{id: warranty_id, value: String.to_float(value), province: province})
    proposals |> List.replace_at(proposal_index, proposal)
  end

  defp parse_object(proposals, [_, "proponent", "added", _, proposal_id, proponent_id, name, age, monthly_income, is_main]) do
    {proposal_index, proposal} = proposal_with_index(proposals, proposal_id)

    proposal = Proposal.add_proponent(proposal, 
      %{
        id:             proponent_id,
        name:           name,
        age:            String.to_integer(age),
        monthly_income: String.to_float(monthly_income),
        main:           is_main  
      }
    )
    proposals |> List.replace_at(proposal_index, proposal)
  end

  defp parse_object(proposals, event) do
  end

  defp proposal_with_index(proposals, proposal_id) do
    proposal_index = 
      proposals
      |> Enum.find_index(&(&1.id == proposal_id))

    proposal = proposals |> Enum.at(proposal_index)
    {proposal_index, proposal}
  end
end
