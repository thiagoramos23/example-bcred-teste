defmodule Proposals.ProcessTest do
  use ExUnit.Case, async: false

  import Fixtures.EventFixture

  test "process a valid proposal" do
    events = events_example()
    approved_proposals = Proposals.Process.process_events(events)
    assert approved_proposals == "bd6abe95-7c44-41a4-92d0-edf4978c9f4e,af6e600b-2622-40d1-89ad-d3e5b6cc2fdf"
  end
end
