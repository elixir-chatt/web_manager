defmodule WebManager.Photos.PhotoList do
  defstruct( photos: [] )
  
  def show_photos(photos, :all), do: []
  def show_photos(photos, :rejected), do: []
  def show_photos(photos, :accepted), do: []
  def show_photos(photos, :pending), do: []
  
  def accept(photos, id) do
    # find...
    # accept...
    # replace...
  end


  def reject(photos, id) do
    # find...
    # reject...
    # replace...
  end
  
  def next_photo(photos, photo) do
  end
end
