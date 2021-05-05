defmodule Fixtures.EventFixture do

  alias Proposals.Core.{Proposal, Warranty, Proponent}
  def events_example1 do
    """
    c2d06c4f-e1dc-4b2a-af61-ba15bc6d8610,proposal,created,2019-11-11T13:26:04Z,bd6abe95-7c44-41a4-92d0-edf4978c9f4e,684397.0,72
    27179730-5a3a-464d-8f1e-a742d00b3dd3,warranty,added,2019-11-11T13:26:04Z,bd6abe95-7c44-41a4-92d0-edf4978c9f4e,6b5fc3f9-bb6b-4145-9891-c7e71aa87ca2,1967835.53,ES
    716de46f-9cc0-40be-b665-b0d47841db4c,warranty,added,2019-11-11T13:26:04Z,bd6abe95-7c44-41a4-92d0-edf4978c9f4e,1750dfe8-fac7-4913-b946-ab538dce0977,1608429.56,GO
    05588a09-3268-464f-8bc8-03974303332a,proponent,added,2019-11-11T13:26:04Z,bd6abe95-7c44-41a4-92d0-edf4978c9f4e,5f9b96d2-b8db-48a8-a28b-f7ac9b3c8108,Kip Beer,50,73300.95,true
    0fe9465f-af17-452c-9abe-fa64d475d8ad,proponent,added,2019-11-11T13:26:04Z,bd6abe95-7c44-41a4-92d0-edf4978c9f4e,fc1a95db-5468-4a37-9a49-9b15b9e250e6,Dong McDermott,50,67287.16,false
    814695b6-f44e-491b-9921-af806f5bb25c,proposal,created,2019-11-11T13:27:22Z,af6e600b-2622-40d1-89ad-d3e5b6cc2fdf,2908382.0,108
    cc08d0d2-e519-495f-b7d6-db6391c21958,warranty,added,2019-11-11T13:27:22Z,af6e600b-2622-4d1-89ad-d3e5b6cc2fdf,37113e50-26ae-48d2-aaf4-4cda8fa76c79,6040545.22,BA
    f72d0829-beac-45bb-b235-7fa16b117c43,warranty,added,2019-11-11T13:27:22Z,af6e600b-2622-40d1-89ad-d3e5b6cc2fdf,8ade6e09-cb60-4a97-abbb-b73bf4bd8f76,6688872.79,DF
    5d9e1ec6-9304-40a1-947f-ab5ea993d100,proponent,added,2019-11-11T13:27:22Z,af6e600b-2622-40d1-89ad-d3e5b6cc2fdf,2213ea91-4a3c-46a3-b3a7-ff55c2888561,Kathline Ferry,50,168896.38,true
    23060b08-32bf-4e53-9866-69f6bcc7fdbd,proponent,added,2019-11-11T13:27:22Z,af6e600b-2622-40d1-89ad-d3e5b6cc2fdf,7526214a-cd5b-4e49-a723-e031bc82dcef,Merle Leuschke,50,143081.9,false
    """
  end

  def proposal_for_event1 do
    proposal = Proposal.new(%{id: "bd6abe95-7c44-41a4-92d0-edf4978c9f4e", loan_value: "684397.0", number_of_monthly_installments: "72"})
    warranty_fields = %{proposal_id: "bd6abe95-7c44-41a4-92d0-edf4978c9f4e", id: "6b5fc3f9-bb6b-4145-9891-c7e71aa87ca2", value: "1967835.53", province: "ES"}
    proposal = Proposal.add_warranty(proposal, warranty_fields)
  end

  def events_example2 do
    """
    c2d06c4f-e1dc-4b2a-af61-ba15bc6d8610,proposal,created,2019-11-11T13:26:04Z,bd6abe95-7c44-41a4-92d0-edf4978c9f4e,684397.0,72
    27179730-5a3a-464d-8f1e-a742d00b3dd3,warranty,added,2019-11-11T13:26:04Z,bd6abe95-7c44-41a4-92d0-edf4978c9f4e,6b5fc3f9-bb6b-4145-9891-c7e71aa87ca2,1967835.53,ES
    716de46f-9cc0-40be-b665-b0d47841db4c,warranty,added,2019-11-11T13:26:04Z,bd6abe95-7c44-41a4-92d0-edf4978c9f4e,1750dfe8-fac7-4913-b946-ab538dce0977,1608429.56,GO
    05588a09-3268-464f-8bc8-03974303332a,proponent,added,2019-11-11T13:26:04Z,bd6abe95-7c44-41a4-92d0-edf4978c9f4e,5f9b96d2-b8db-48a8-a28b-f7ac9b3c8108,Kip Beer,50,73300.95,true
    0fe9465f-af17-452c-9abe-fa64d475d8ad,proponent,added,2019-11-11T13:26:04Z,bd6abe95-7c44-41a4-92d0-edf4978c9f4e,fc1a95db-5468-4a37-9a49-9b15b9e250e6,Dong McDermott,50,67287.16,false
    814695b6-f44e-491b-9921-af806f5bb25c,proposal,created,2019-11-11T13:27:22Z,af6e600b-2622-40d1-89ad-d3e5b6cc2fdf,2908382.0,108
    cc08d0d2-e519-495f-b7d6-db6391c21958,warranty,added,2019-11-11T13:27:22Z,af6e600b-2622-4d1-89ad-d3e5b6cc2fdf,37113e50-26ae-48d2-aaf4-4cda8fa76c79,6040545.22,BA
    f72d0829-beac-45bb-b235-7fa16b117c43,warranty,added,2019-11-11T13:27:22Z,af6e600b-2622-40d1-89ad-d3e5b6cc2fdf,8ade6e09-cb60-4a97-abbb-b73bf4bd8f76,6688872.79,DF
    5d9e1ec6-9304-40a1-947f-ab5ea993d100,proponent,added,2019-11-11T13:27:22Z,af6e600b-2622-40d1-89ad-d3e5b6cc2fdf,2213ea91-4a3c-46a3-b3a7-ff55c2888561,Kathline Ferry,50,168896.38,true
    23060b08-32bf-4e53-9866-69f6bcc7fdbd,proponent,added,2019-11-11T13:27:22Z,af6e600b-2622-40d1-89ad-d3e5b6cc2fdf,7526214a-cd5b-4e49-a723-e031bc82dcef,Merle Leuschke,50,143081.9,false
    """
  end

  def events_example_with_repeated_event do
    """
    c2d06c4f-e1dc-4b2a-af61-ba15bc6d8610,proposal,created,2019-11-11T13:26:04Z,bd6abe95-7c44-41a4-92d0-edf4978c9f4e,684397.0,72
    27179730-5a3a-464d-8f1e-a742d00b3dd3,warranty,added,2019-11-11T13:26:04Z,bd6abe95-7c44-41a4-92d0-edf4978c9f4e,6b5fc3f9-bb6b-4145-9891-c7e71aa87ca2,1967835.53,ES
    27179730-5a3a-464d-8f1e-a742d00b3dd3,warranty,added,2019-11-11T13:26:04Z,bd6abe95-7c44-41a4-92d0-edf4978c9f4e,6b5fc3f9-bb6b-4145-9891-c7e71aa87ca2,1967835.53,ES
    716de46f-9cc0-40be-b665-b0d47841db4c,warranty,added,2019-11-11T13:26:04Z,bd6abe95-7c44-41a4-92d0-edf4978c9f4e,1750dfe8-fac7-4913-b946-ab538dce0977,1608429.56,GO
    05588a09-3268-464f-8bc8-03974303332a,proponent,added,2019-11-11T13:26:04Z,bd6abe95-7c44-41a4-92d0-edf4978c9f4e,5f9b96d2-b8db-48a8-a28b-f7ac9b3c8108,Kip Beer,50,73300.95,true
    0fe9465f-af17-452c-9abe-fa64d475d8ad,proponent,added,2019-11-11T13:26:04Z,bd6abe95-7c44-41a4-92d0-edf4978c9f4e,fc1a95db-5468-4a37-9a49-9b15b9e250e6,Dong McDermott,50,67287.16,false
    814695b6-f44e-491b-9921-af806f5bb25c,proposal,created,2019-11-11T13:27:22Z,af6e600b-2622-40d1-89ad-d3e5b6cc2fdf,2908382.0,108
    cc08d0d2-e519-495f-b7d6-db6391c21958,warranty,added,2019-11-11T13:27:22Z,af6e600b-2622-4d1-89ad-d3e5b6cc2fdf,37113e50-26ae-48d2-aaf4-4cda8fa76c79,6040545.22,BA
    f72d0829-beac-45bb-b235-7fa16b117c43,warranty,added,2019-11-11T13:27:22Z,af6e600b-2622-40d1-89ad-d3e5b6cc2fdf,8ade6e09-cb60-4a97-abbb-b73bf4bd8f76,6688872.79,DF
    5d9e1ec6-9304-40a1-947f-ab5ea993d100,proponent,added,2019-11-11T13:27:22Z,af6e600b-2622-40d1-89ad-d3e5b6cc2fdf,2213ea91-4a3c-46a3-b3a7-ff55c2888561,Kathline Ferry,50,168896.38,true
    23060b08-32bf-4e53-9866-69f6bcc7fdbd,proponent,added,2019-11-11T13:27:22Z,af6e600b-2622-40d1-89ad-d3e5b6cc2fdf,7526214a-cd5b-4e49-a723-e031bc82dcef,Merle Leuschke,50,143081.9,false
    """
  end
end
