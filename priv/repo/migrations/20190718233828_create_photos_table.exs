defmodule WebManager.Repo.Migrations.CreatePhotosTable do
  use Ecto.Migration

  def change do
    create table(:photos) do
      add :path, :string
      add :status, :string
      add :troll, :boolean

      timestamps()
    end
  end
end
