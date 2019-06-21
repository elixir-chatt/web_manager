defmodule WebManager.Photos.PhotoList do
  defstruct( photos: [] )
  
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
  
  def add_photo(list, photo) do
    [photo|list]
  end
  
  
  
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
