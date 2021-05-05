defmodule Proposals.Core.Proposal do
  defstruct [:id, :loan_value, :number_of_monthly_installments, warranties: [], proponents: []]

  alias Proposals.Core.{Proposal, Proponent, Warranty, Validator}

  def new(fields) do
    struct!(__MODULE__, fields)
  end

  def add_warranty(proposal, warranty_fields) do

  end

  def updated_warranty(proposal, warranty_fields) do

  end

  def add_proponent(proposal, proponent_fields) do

  end

  def update_proponent(proposal, proponent_fields) do

  end

  def remove_warranty(proposal_id, warranty_id) do

  end

  def remove_proponent(proposal_id, proponent_id) do

  end

  def valid?(proposal) do
    proposal
    |> to_validator()
    |> evaluate(&valid_loan_value?/1)
    |> evaluate(&valid_number_of_monthly_installments?/1)
    |> evaluate(&has_at_least_two_proponents?/1)
    |> evaluate(&has_exactly_one_proponent?/1)
    |> evaluate(&has_all_proponents_older_than_eighteen?/1)
    |> evaluate(&has_monthly_income_accordingly_to_the_age?/1)
    |> evaluate(&has_warranty?/1)
    |> evaluate(&warranties_double_or_more_than_loan_value?/1)
    |> evaluate(&warranty_from_valid_province?/1)
    |> result()
  end

  defp result(validator) do
    validator.is_valid
  end

  defp valid_loan_value?(proposal) do
    proposal.loan_value >= 30000
  end

  defp valid_number_of_monthly_installments?(proposal) do
    proposal.number_of_monthly_installments >= 24  && proposal.number_of_monthly_installments <= 180
  end

  defp has_at_least_two_proponents?(proposal) do
    Enum.count(proposal.proponents) >= 2
  end

  defp has_exactly_one_proponent?(proposal) do
    number_of_main_proponents = 
      proposal.proponents
      |> Enum.count(&(&1.main == true))

    number_of_main_proponents == 1
  end

  defp has_all_proponents_older_than_eighteen?(proposal) do
    proposal.proponents
    |> Enum.all?(&(Proponent.valid?(&1)))
  end

  defp has_monthly_income_accordingly_to_the_age?(proposal) do
    main_proponent            = Enum.find(proposal.proponents, &(&1.main == true))
    monthly_installment_value = proposal.loan_value / proposal.number_of_monthly_installments
    has_valid_income?(main_proponent, monthly_installment_value)
  end

  defp has_valid_income?(proponent, monthly_installment_value) when proponent.age >= 18 and proponent.age < 24 do
    proponent.monthly_income >= monthly_installment_value * 4
  end
  defp has_valid_income?(proponent, monthly_installment_value) when proponent.age >= 24 and proponent.age <= 50 do
    proponent.monthly_income >= monthly_installment_value * 3
  end
  defp has_valid_income?(proponent, monthly_installment_value) when proponent.age > 50 do
    proponent.monthly_income >= monthly_installment_value * 2
  end

  defp has_warranty?(proposal) do
    !Enum.empty?(proposal.warranties)
  end

  defp warranties_double_or_more_than_loan_value?(proposal) do
    sum_all_warranty_values = 
      proposal.warranties
      |> Enum.map(&(&1.value))
      |> Enum.sum

    sum_all_warranty_values >= (proposal.loan_value * 2)
  end

  defp warranty_from_valid_province?(proposal) do
    proposal.warranties
    |> Enum.all?(&Warranty.valid?(&1))
  end

  defp to_validator(proposal) do
    Validator.new(proposal)
  end

  defp evaluate(validator, function) do
    Validator.validate(validator, function)
  end
end
