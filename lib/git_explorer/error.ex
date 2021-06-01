defmodule GitExplorer.Error do
  @attributes [:status, :reason]
  @enforce_keys @attributes

  defstruct @attributes

  @type t :: %__MODULE__{status: atom(), reason: map() | String.t()}

  def build(reason, status) do
    %__MODULE__{
      reason: reason,
      status: status
    }
  end
end
