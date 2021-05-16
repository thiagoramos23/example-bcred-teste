defmodule ProposalsTest do
  use ExUnit.Case, async: false
  import Fixtures.EventFixture

  test "given a set of events where the proposal is valid return if the proposal is valid" do
    valid_proposals = Proposals.valid_proposals(events_example1)
    assert Enum.count(valid_proposals) == 1
  end
end
