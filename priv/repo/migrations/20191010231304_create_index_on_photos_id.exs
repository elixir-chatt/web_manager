defmodule WebManager.Repo.Migrations.CreateIndexOnPhotosId do
  use Ecto.Migration

  def change do
    create index(:photos, [:id])
  end

end
