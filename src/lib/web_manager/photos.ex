defmodule WebManager.Photos do
  import Ecto.Query, warn: false

  alias WebManager.Repo
  alias WebManager.Photos.Photo

  def create(attrs) do
    %Photo{}
    |> Photo.changeset(attrs)
    |> Repo.insert()
  end

  def accept(photo) do

  end

  def reject(photo) do

  end

  def send_to_s3(photo) do

  end

  def list_by_status(status) when status in [:all, "all"]  do
    Photo
    |> Repo.all
  end

  def list_by_status(status) do
    from(photo in Photo, where: photo.status == ^to_string(status))
    |> Repo.all
  end
  
  def find(id) do
    Repo.get Photo, id
  end
end
