defmodule Proposals.Parser.EventParserTest do
  use ExUnit.Case, async: false
  import Fixtures.EventFixture

  alias Proposals.Core.{Proposal, Warranty, Proponent}

  test "parse/1 create an proposal when event is to create a proposal" do
    event = "c2d06c4f-e1dc-4b2a-af61-ba15bc6d8610,proposal,created,2019-11-11T13:26:04Z,bd6abe95-7c44-41a4-92d0-edf4978c9f4e,684397.0,72"
    proposal = %Proposal{id: "bd6abe95-7c44-41a4-92d0-edf4978c9f4e", loan_value: 684397.0, number_of_monthly_installments: 72}
    proposals = Proposals.Parser.EventParser.parse(event)

    assert Enum.count(proposals) == 1
    assert List.first(proposals) == proposal
  end
end
