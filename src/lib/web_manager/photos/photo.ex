#
  # How is this related to the folder structure
defmodule WebManager.Photos.Photo do
  @moduledoc """
  Photo data model representing a single photo in our manager.
  """
  @type t :: %__MODULE__{
    path: String.t(),
    status: String.t(),
    troll: boolean
  }

  # What is use and what is a schema?
    # A bit of code that let's another module add whatever code it wants to from
    # another module so that we can use it here
    # So that let's us use field for example instead of having to call
    # Ecto.Schema.field() like you see starting on line 20
  use Ecto.Schema
  # What does import do?
    # Kind of like use insofar that we can call functions without using the fully
    # qualified name aka validate_required instead of Ecto.Changeset.case() for
    # example
  import Ecto.Changeset

  # What do you think this is?
    # This is called a module attribute. Elixir programers often use these to hold
    # important static info that we want to call attention to.
  @statuses ["pending", "accepted", "rejected"]

  # `schema` is provided by what?
    # `Ecto.Schema`

  # What does a schema do?
    # A schema is a module that defines mappings to the underlying database table’s fields.
  schema "photos" do
    # What is field?
      # a function
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

  # Anyone know what a changeset is?
    # Most simply it is a function that makes sure our data or a set of changes
    # is in the right state before we store those changes in the database.
    # What's more is that Ecto which let's us put stuff in a database expects
    # a changeset struct.
    # But what is a struct?

  #
    # But why would we care about that?
      # Think about what would happen if we stored some unexpected data in a field.
      # Say we expected path to be a string but some how a number was put in there.
      # What do you think would happen?
  def changeset(photo, attrs) do
    # Let's step through this code line by line.
    photo
    |> cast(attrs, [:path, :status, :troll])
    |> validate_required([:path, :status, :troll])
    |> validate_subset(:status, @statuses)
  end

  #
    # Now that we have a schema?
      # mix ecto.gen.migration add_photo_table_and_fields
end
