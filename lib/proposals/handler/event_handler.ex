defmodule Proposals.Handler.EventHandler do
  @type event() :: Proposals.Handler.EventHandler.Event.t()
  @type events() :: [event]

  defmodule Event do
    defstruct [:id, :schema, :action, :timestamp, :proposal_id, :data]

    def to_event(event_string) do
      [id, schema, action, timestamp, proposal_id | tail] = event_string |> String.split(",")
      %Event{id: id, schema: schema, action: action, timestamp: timestamp, proposal_id: proposal_id, data: tail}
    end
  end

  alias Proposals.Handler.EventHandler.Event

  @spec handle_events(String.t()) :: events()
  def handle_events(events) do
    events 
      |> String.split("\n")
      |> Enum.reject(&(&1 == ""))
      |> Enum.map(&Event.to_event/1)
      |> deduplicate_events()
      |> discard_old_update_event_that_comes_later()
  end

  defp deduplicate_events(events) do
    Enum.reduce(events, [], fn event, list -> 
      case Enum.find(list, &(&1.id == event.id)) do
        nil ->
          [event | list]
      end
    end)
    |> Enum.reverse()
  end

  defp discard_old_update_event_that_comes_later(events) do
    grouped_by_proposal = Enum.group_by(events, &(&1.proposal_id))
    Enum.flat_map(grouped_by_proposal, fn {_, value_list} -> 
      by_schema_action = Enum.group_by(value_list, &(by_schema_action(&1)))
      Enum.reduce(by_schema_action, [], fn {key, value_list}, list -> 
        case key do
          "_" -> 
            list ++ value_list
          _ ->
            first_timestamp = List.first(value_list).timestamp
            list ++ Enum.filter(value_list, &(&1.timestamp >= first_timestamp))
        end
      end)
    end)
  end

  defp by_schema_action(%Event{schema: "proponent", action: "added"}), do: "proponent_added"
  defp by_schema_action(%Event{schema: "proponent", action: "updated"}), do: "proponent_updated"
  defp by_schema_action(%Event{schema: "warranty", action: "added"}), do: "warranty_added"
  defp by_schema_action(%Event{schema: "warranty", action: "updated"}), do: "warranty_updated"
  defp by_schema_action(%Event{schema: "proposal", action: "updated"}), do: "proposal_updated"
  defp by_schema_action(_), do: "_"
end
