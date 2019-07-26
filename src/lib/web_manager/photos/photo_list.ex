defmodule WebManager.Photos.PhotoList do
  alias WebManager.Photos.Photo
  @type t :: %__MODULE__{
    photos: [Photo.t()]
  }

  defstruct( photos: [] )

  alias WebManager.Photo

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

  def accept(_photos, id, status \\ :pending) do
    id
    |>Photos.find 
    |>Photos.accept
    
    Photos.list_by_status(status)
  end


  def reject(_photos, id, status \\ :pending) do
    id
    |> Photos.find 
    |> Photos.reject

    Photos.list_by_status(status)
  end

  def next_photo(photos, photo) do
    current_photo_index = Enum.find_index(photos, fn x -> x == photo end)
    Enum.fetch!(photos, current_photo_index+1)
    #TODO wrap around the list if last photo
  end
  
  def next_photo(id) do
    Photos.list_by_status(:accepted)
  end
end
