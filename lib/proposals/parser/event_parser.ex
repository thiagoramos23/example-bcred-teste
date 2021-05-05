defmodule Proposals.Parser.EventParser do

  alias Proposals.Core.{Proposal, Warranty, Proponent}

  def parse(event) do
    proposals    = []
    event_fields = String.split(event, ",")
    parse_object(proposals, event_fields)
  end

  defp parse_object(proposals, [_, "proposal", "created", _, proposal_id, loan_value, number_of_monthly_installments]) do
    fields = %{id: proposal_id, loan_value: String.to_float(loan_value), number_of_monthly_installments: String.to_integer(number_of_monthly_installments)}
    proposal = Proposal.new(fields)
    [proposal | proposals]
  end

  defp parse_object(proposals, event) do

  end
end
