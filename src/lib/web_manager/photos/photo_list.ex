defmodule WebManager.Photos.PhotoList do
  defstruct( photos: [] )

  def show_photos(photos, :all), do: []
  def show_photos(photos, :rejected), do: []
  def show_photos(photos, :accepted), do: []
  def show_photos(photos, :pending), do: []

  def accept(photos, id) do
    accepted_photo = photos
    |> Enum.find(fn x -> x.id == id end)
    |> Photo.accept

    index = Enum.find_index(photos, fn x -> x.id == id end)
    List.replace_at(photos, index, accepted_photo)
  end


  def reject(photos, id) do
    rejected_photo = photos
    |> Enum.find(fn x -> x.id == id end)
    |> Photo.reject

    index = Enum.find_index(photos, fn x -> x.id == id end)
    List.replace_at(photos, index, rejected_photo)
  end

  def next_photo(photos, photo) do
    current_photo_index = Enum.find_index(photos, fn x -> x == photo end)
    Enum.fetch!(photos, current_photo_index+1)
    #TODO wrap around the list if last photo
  end
end
