defmodule WebManager.Photos do
  import Ecto.Query, warn: false
  defstruct( photos: [] )

  alias WebManager.{Repo, Uploader}
  alias WebManager.Photos.{Photo, Troll}

  def accept(id) do
    id
    |> find
    |> Photo.changeset(%{status: "accepted"})
    |> Repo.update!
  end

  def reject(id) do
    id
    |> find
    |> Photo.changeset(%{status: "rejected"})
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
    |> Enum.map(fn x -> x.id end)
    |> Enum.drop_while(fn(photo_id) -> photo_id != id end)
    |> second
  end

  def second([_first, second | _rest]), do: second
  def second(_), do: list_by_status(:accepted) |> List.first |> Map.get(:id)
  
  def upload_and_create(jpg, group, index, troll) do
    {:ok, path} = Uploader.upload_to_s3(jpg, group, index)
    
    create(%{ path: path, status: "pending", troll: troll=="true"}) |> IO.inspect
  end
  
  def post_fake_to_self() do
    post_fake_to_self(:random.uniform(5), [true, false] |> Enum.shuffle |> hd)
  end
  
  def post_fake_to_self(index, troll) do
    path = "./priv/static/images/#{:random.uniform(5)}.jpg"
    host = Application.get_env :web_manager, :full_host
    {:ok, jpg} = File.read(path) 
    
    HTTPoison.post(
      "#{host}/api/photos", 
      jpg, 
        [
          {"Content-Type", "image/jpeg"}, 
          {"Content-length", to_string byte_size(jpg)},
          {"Index", to_string(index)},
          {"Troll", troll}, 
          {"GTS", "#{DateTime.to_unix DateTime.utc_now}"}
   	    ]
      )
  end
  
  def s3_path(object) do
    {:ok, url} = ExAws.S3.presigned_url(ExAws.Config.new(:s3), :get, "photobooth", object)
    url
  end
  
  def create_troll(troll) do
    Troll.changeset(troll)
    |> Repo.insert
  end
  
  def last_troll() do
    Troll |> last |> Repo.one |> troll
  end
  
  def check_and_clear_troll() do
    result = last_troll()
    create_troll false
    result
  end
  
  def troll(nil), do: false
  def troll(troll), do: troll.troll
end
