defmodule WebManager.Photos.Photo do
  @moduledoc """
  Photo data model representing a single photo in our manager.
  """
  @type t :: %__MODULE__{
    path: String.t(),
    status: String.t(),
    troll: boolean
  }

  use Ecto.Schema
  import Ecto.Changeset

  @statuses ["pending", "accepted", "rejected"]

  schema "photos" do
    field(:path, :string)
    field(:status, :string)
    field(:troll, :boolean)

    timestamps()
  end

  def accept(photo) do
    %{photo | status: "accepted"}
  end

  def reject(photo) do
    %{photo | status: "rejected"}
  end

  def changeset(photo, attrs) do
    photo
    |> cast(attrs, [:path, :status, :troll])
    |> validate_required([:path, :status, :troll])
    |> validate_inclusion(:status, @statuses)
  end
end
