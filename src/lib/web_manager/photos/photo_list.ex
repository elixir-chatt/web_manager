defmodule WebManager.Photos.PhotoList do
  alias WebManager.Photos.Photo
  @type t :: %__MODULE__{
    photos: [Photo.t()]
  }

  defstruct( photos: [] )

  alias WebManager.PhotoService

  def show_photos(photos, :all) do
    photos
  end

  def show_photos(photos, :rejected) do
    Enum.filter(photos, &rejected?/1)
  end

  def show_photos(photos, :accepted) do
    Enum.filter(photos, &accepted?/1)
  end
  def show_photos(photos, :pending) do
    Enum.filter(photos, &pending?/1)
  end

  def rejected?(photo) do
    photo.status == :rejected
  end

  def accepted?(photo) do
    photo.status == :accepted
  end

  def pending?(photo) do
    photo.status == :pending
  end

  def add_all(photos) do
    Enum.map(photos, &process_photo/1)
  end

  def process_photo(%{photo: _bytes, troll: _troll, id: _id}) do
    # url = send_to_s3 bytes, id
    # write_to_db url, troll, id
    # add_to_liveview(to_photo url, troll, id)
  end

  def add_photo(list, photo) do
    [photo|list]
  end

  def accept(photos, id) do
    accepted_photo = photos
    |> Enum.find(fn x -> x.id == id end)
    |> PhotoService.accept

    index = Enum.find_index(photos, fn x -> x.id == id end)
    List.replace_at(photos, index, accepted_photo)
  end


  def reject(photos, id) do
    rejected_photo = photos
    |> Enum.find(fn x -> x.id == id end)
    |> PhotoService.reject

    index = Enum.find_index(photos, fn x -> x.id == id end)
    List.replace_at(photos, index, rejected_photo)
  end

  def next_photo(photos, photo) do
    current_photo_index = Enum.find_index(photos, fn x -> x == photo end)
    Enum.fetch!(photos, current_photo_index+1)
    #TODO wrap around the list if last photo
  end
end
