defmodule Proposals do
  @moduledoc """
  Documentation for `Proposals`.
  """

  @type valid_proposals :: [String.t()]
  @type event_string    :: String.t()

  @spec valid_proposals(event_string()) :: valid_proposals()
  def valid_proposals(events) do
    proposals = []
    event_list = handle_events(events)
    proposals = parse_proposals(proposals, event_list)

    Enum.reduce(proposals, [], &get_valid_proposals(&1, &2))
    |> Enum.map(fn proposal -> proposal.id end)
  end

  defp get_valid_proposals(proposal, valid_proposals) do
    case Proposals.Core.Proposal.valid?(proposal) do
      true ->
        [proposal | valid_proposals]
      false ->
        valid_proposals
    end
  end

  defp handle_events(events) do
    Proposals.Handler.EventHandler.handle_events(events)
  end

  defp parse_proposals(proposals, [head | tail]) do
    proposals = Proposals.Parser.EventParser.parse(head, proposals)
    parse_proposals(proposals, tail)
  end
  defp parse_proposals(proposals, []), do: proposals
end
