defmodule WebManagerWeb.SlideshowLive do
  use Phoenix.LiveView
  alias WebManager.Photos

  def render(assigns) do
    ~L"""
      <div class="slide-show-image-container">
      <img class="slide-show-image" src="/images/<%= @photo.path %>" />
      <div class="troll-icon"><i class="far fa-grin-squint-tears"></i></div>
      </div>
    """
  end

  def mount(_session, socket) do
    if connected?(socket), do: :timer.send_interval(3000, self(), :tick)

    photo_id = Photos.next_photo(nil)

    {
      :ok,
      assign(
        socket,
        photo_id: photo_id,
        photo: Photos.find(photo_id)
      )
    }
  end

  def change_photo(socket) do
    photo_id = Photos.next_photo(socket.assigns.photo_id)

    assign(
      socket,
      photo_id: photo_id,
      photo: Photos.find(photo_id)
    )

  end

  def handle_info(:tick, socket) do
    {:noreply, change_photo(socket)}
  end
end
