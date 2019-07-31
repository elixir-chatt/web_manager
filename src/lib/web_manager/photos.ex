defmodule WebManager.Photos do
  import Ecto.Query, warn: false
  alias WebManager.Photos.Photo
  defstruct( photos: [] )

  alias WebManager.Repo

  def accept(id) do
    id
    |> find 
    |> Photo.changeset(%{status: :acceped})
    |> Repo.update!
  end
  
  def reject(id) do
    id
    |> find 
    |> Photo.changeset(%{status: :rejected})
    |> Repo.update!
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

  def create(attrs) do
    %Photo{}
    |> Photo.changeset(attrs)
    |> Repo.insert()
  end
  
  def add_path(%Photo{}=photo, path) do
    photo
    |> Photo.changeset(%{path: path})
    |> Repo.update!
  end
  
  def add_path(id, path) do
    id
    |> find
    |> add_path(path)
  end
  
  def process_photos(photos) do
    Enum.each photos, &process_photo/1
  end

  def process_photo(%{photo: bytes, troll: troll}) do
    {:ok, photo_without_path} = create(troll: troll, status: :pending)
    
    photo_without_path
    |> send_to_s3(bytes)
    |> create  
  end
  
  # TODO: back by s3
  def send_to_s3(photo, bytes) do
    {:ok, path} = process_for_s3(photo, bytes)
    add_path(photo, path)
  end
  
  # TODO: implement this with real S3 mechanics
  def process_for_s3(%Photo{id: id}, _bytes) do
    path = "/photos/photo#{id}.jpg"
    # send to s3
    {:ok, path}
  end

  def next_photo(id) do
    list_by_status(:accepted)
    |> Enum.map(& &1.id)
    |> Enum.drop_while(fn(pid) -> pid != id end)
    |> List.first
    |> id_or_first
  end
  
  def id_or_first(nil) do
    (List.first(list_by_status(:accepted)) || %{})
    |> Map.get(:id)
  end
  def id_or_first(id), do: id
end

