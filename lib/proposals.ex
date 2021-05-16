defmodule Proposals do
  @moduledoc """
  Documentation for `Proposals`.
  """

  @doc """

  ## Examples

    iex> Proposals.valid_proposal?(events)
    true 

  """
  def valid_proposals(events) do
    proposals = []
    valid_proposals = []
    event_list = 
      events 
      |> String.split("\n")
      |> Enum.reject(&(&1 == ""))

    proposals = parse_proposals(proposals, event_list)
    get_valid_proposals(valid_proposals, proposals)
  end

  defp get_valid_proposals(valid_proposals, [head | tail]) do
    case Proposals.Core.Proposal.valid?(head) do
      true ->
        valid_proposals = [head | valid_proposals]
        get_valid_proposals(valid_proposals, tail)

      false ->
        get_valid_proposals(valid_proposals, tail)
    end
  end
  defp get_valid_proposals(valid_proposals, []), do: valid_proposals

  defp parse_proposals(proposals, [head | tail]) do
    proposals = Proposals.Parser.EventParser.parse(head, proposals)
    parse_proposals(proposals, tail)
  end
  defp parse_proposals(proposals, []), do: proposals
end
