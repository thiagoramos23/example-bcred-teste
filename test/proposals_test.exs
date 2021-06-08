defmodule ProposalsTest do
  use ExUnit.Case, async: false
  import Fixtures.EventFixture

  test "given a set of events where the proposal is valid return the valid proposals" do
    valid_proposals = Proposals.valid_proposals(events_example1())
    assert Enum.count(valid_proposals) == 2
    assert valid_proposals == ["af6e600b-2622-40d1-89ad-d3e5b6cc2fdf", "bd6abe95-7c44-41a4-92d0-edf4978c9f4e"]
  end

  test "given a set of events with only one proposal valid return only the valid proposal" do
    events = events_with_one_proposal_valid_and_another_without_main_proponent()
    valid_proposals = Proposals.valid_proposals(events)
    assert Enum.count(valid_proposals) == 1
    assert valid_proposals == ["bd6abe95-7c44-41a4-92d0-edf4978c9f4e"]
    end
end
