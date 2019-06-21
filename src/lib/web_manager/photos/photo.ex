defmodule WebManager.Photos.Photo do
  defstruct [:path, :id, troll: false, status: :pending ]

  def accept(photo) do
    %{photo | status: :accepted}
  end

  def reject(photo) do
    %{photo | status: :rejected}
  end
end
