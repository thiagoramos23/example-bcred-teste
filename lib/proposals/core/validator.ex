defmodule Proposals.Core.Validator do
  defstruct [:data, is_valid: true]

  def new(data) do
    %Proposals.Core.Validator{data: data}
  end

  def validate(%Proposals.Core.Validator{is_valid: true} = validator, func) do
    is_valid = func.(validator.data)
    %Proposals.Core.Validator{is_valid: is_valid, data: validator.data}
  end
  def validate(validator, _func), do: validator
end
