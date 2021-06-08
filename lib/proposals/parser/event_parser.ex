defmodule Proposals.Parser.EventParser do

  alias Proposals.Core.Proposal
  alias Proposals.Handler.EventHandler.Event

  def parse(event, proposals) do
    parse_object(proposals, event)
  end

  defp parse_object(proposals, %Event{schema: "proposal", action: "created", proposal_id: proposal_id, data: [loan_value, number_of_monthly_installments]}) do
    fields = %{id: proposal_id, loan_value: String.to_float(loan_value), number_of_monthly_installments: String.to_integer(number_of_monthly_installments)}
    proposal = Proposal.new(fields)
    [proposal | proposals]
  end
  defp parse_object(proposals, %Event{schema: "warranty", action: "added", proposal_id: proposal_id, data: [warranty_id, value, province]}) do
    {proposal_index, proposal} = proposal_with_index(proposals, proposal_id)

    proposal = Proposal.add_warranty(proposal, %{id: warranty_id, value: String.to_float(value), province: province})
    proposals |> List.replace_at(proposal_index, proposal)
  end
  defp parse_object(proposals, %Event{schema: "proponent", action: "added", proposal_id: proposal_id, data: [proponent_id, name, age, monthly_income, is_main]}) do
    {proposal_index, proposal} = proposal_with_index(proposals, proposal_id)
    main = if (is_main == "true"), do: true, else: false

    proposal = Proposal.add_proponent(proposal, 
      %{
        id:             proponent_id,
        name:           name,
        age:            String.to_integer(age),
        monthly_income: String.to_float(monthly_income),
        main:           main 
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
