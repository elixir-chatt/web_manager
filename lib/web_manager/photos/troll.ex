defmodule WebManager.Photos.Troll do
  use Ecto.Schema
  import Ecto.Changeset

  schema "trolls" do
    field(:troll, :boolean)
  end
  
  def changeset(troll) do
    __MODULE__.__struct__
    |> cast(%{troll: troll}, [:troll])
  end
end