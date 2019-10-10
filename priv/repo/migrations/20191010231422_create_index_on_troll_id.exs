defmodule WebManager.Repo.Migrations.CreateIndexOnTrollId do
  use Ecto.Migration

  def change do
    create index(:trolls, [:id])
  end
end
