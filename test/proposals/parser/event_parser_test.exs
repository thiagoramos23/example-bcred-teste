defmodule Proposals.Parser.EventParserTest do
  use ExUnit.Case, async: false
  import Fixtures.EventFixture

  alias Proposals.Core.{Proposal, Warranty, Proponent}

  test "parse/1 create an proposal when event is to create a proposal" do
    event = "     c2d06c4f-e1dc-4b2a-af61-ba15bc6d8610,proposal,created,2019-11-11T13:26:04Z,bd6abe95-7c44-41a4-92d0-edf4978c9f4e,684397.0,72    "
    proposal = %Proposal{id: "bd6abe95-7c44-41a4-92d0-edf4978c9f4e", loan_value: 684397.0, number_of_monthly_installments: 72}
    proposals = Proposals.Parser.EventParser.parse(event, [])

    assert Enum.count(proposals) == 1
    assert List.first(proposals) == proposal
  end

  test "parse/1 add warranty when event is to add a warranty to a proposal" do
    event = "27179730-5a3a-464d-8f1e-a742d00b3dd3,warranty,added,2019-11-11T13:26:04Z,bd6abe95-7c44-41a4-92d0-edf4978c9f4e,6b5fc3f9-bb6b-4145-9891-c7e71aa87ca2,1967835.53,ES"
    proposal = %Proposal{id: "bd6abe95-7c44-41a4-92d0-edf4978c9f4e", loan_value: 684397.0, number_of_monthly_installments: 72}
    proposals = [proposal]
    
    proposals = Proposals.Parser.EventParser.parse(event, proposals)

    [proposal | _] = proposals
    [warranty | _] = proposal.warranties

    assert Enum.count(proposals) == 1
    assert Enum.count(proposal.warranties) == 1
    assert warranty.value == 1967835.53
  end

  test "parse/1 add a proponent when event is to add a proponent to a proposal" do
    event = "05588a09-3268-464f-8bc8-03974303332a,proponent,added,2019-11-11T13:26:04Z,bd6abe95-7c44-41a4-92d0-edf4978c9f4e,5f9b96d2-b8db-48a8-a28b-f7ac9b3c8108,Kip Beer,50,73300.95,true"
    proposal = %Proposal{id: "bd6abe95-7c44-41a4-92d0-edf4978c9f4e", loan_value: 684397.0, number_of_monthly_installments: 72}

    proposals = [proposal]
    proposals = Proposals.Parser.EventParser.parse(event, proposals)
    [proposal | _] = proposals
    [proponent | _] = proposal.proponents

    assert Enum.count(proposals) == 1
    assert proponent.name == "Kip Beer"
    assert proponent.age == 50
    assert proponent.monthly_income == 73300.95
    assert proponent.main == "true"
  end
end
