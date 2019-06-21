defmodule WebManager.Photos.Photo do
  @statuses [:pending, :accepted, :rejected]
  
  defstruct [ 
    :path, 
    :id, 
    troll: false, 
    status: :pending 
  ]
  
  def accept(photo) do
  end

  def reject(photo) do
  end
end