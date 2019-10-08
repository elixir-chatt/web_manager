defmodule WebManager.Repo.Migrations.CreateTroll do
  use Ecto.Migration

  def change do
    create table(:trolls) do
      add :troll, :boolean
    end

  end
end
