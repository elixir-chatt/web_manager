defmodule WebManagerWeb.SlideshowLive do
  use Phoenix.LiveView
  alias WebManager.Photos

  def render(assigns) do
    ~L"""
      <div class="slide-show-image-container">
        <img src="<%= Photos.s3_path @photo.path %>" class="slide-show-image" />
        <%= if @photo.troll do %>
        <img width="50px"class="troll" src="/images/troll.png" />
        <% end %>
      </div>
    """
  end

  def mount(_session, socket) do
    if connected?(socket), do: :timer.send_interval(2000, self(), :tick)

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
  
  def troll_class(true), do: "troll"
  def troll_class(false), do: ""
  
  def handle_info(:tick, socket) do
    {:noreply, change_photo(socket)}
  end
end
