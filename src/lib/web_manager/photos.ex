# Does anyone know what a context is?
  # Contexts are dedicated modules that expose and group related functionality.
  # In our case we are going to group the functionality related to persisting
  # to the database. This is also going allow us to NOT sprinkle Repo based functions
  # which means we have more flexibility in the future. It makes it easier
  # to change if we decide we want to get tid of our DB and use something else
  # for persistence.

defmodule WebManager.Photos do
  import Ecto.Query 
  alias WebManager.Repo
  alias WebManager.Photos.Photo
  
  
  def create(photo) do
    
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
