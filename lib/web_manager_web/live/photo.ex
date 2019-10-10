defmodule WebManagerWeb.Photo do
  use Phoenix.LiveView
  alias WebManager.Photos

  def render(assigns) do
    ~L"""
    <section class="phx-hero">
      <h1>Manage Photos from our Photobooth</h1>
      <div class="row">
          <%= render_photos(@photos) |> Phoenix.HTML.raw %>
      </div>
    </section>
    <section>
    <hr/>
    </section>
    <section>
    <div class="container"><h1><a href="/slideshow">Slideshow</a> | <a href="../">Home</a></h1></div>
    </section
    """
  end

  def mount(_session, socket) do
    {
      :ok,
      assign(
        socket,
        person: %{name: "Lucas"},
        photos: Photos.list_by_status(:pending),
        clicked_photo: "---",
        accepted_photo_id: "---",
        rejected_photo_id: "---")
      }
  end

  def add_random_photo(socket) do
      Photos.post_fake_to_self()

    socket
    |> assign(:photos, Photos.list_by_status(:pending))
  end

  def render_photos(photos) do
    photos
    |> Enum.map(&render_photo/1)
  end

  def render_photo(photo) do
    """
    <div class="img-container">
      <a href="#" phx-click="photo" phx-value-id="#{photo.id}" class="thumbnail">
        <img height=100 src="#{Photos.s3_path photo.path}" />
      </a>
      <div class="btns">
        <button href="#" phx-click="reject" phx-value-id="#{photo.id}" id="reject" class="btn btn-reject">👎</button>
        <button href="#" phx-click="accept" phx-value-id="#{photo.id}" id="accept" class="btn btn-accept">👍</button>
      </div>
    </div>
    """
  end

  def accept(photo_id, socket) do
    Photos.accept(photo_id)

    assign(
      socket,
      accepted_photo_id: photo_id,
      photos: Photos.list_by_status(:pending))
  end

  def reject(photo_id, socket) do
    Photos.reject(photo_id)

    assign(
      socket,
      rejected_photo_id: photo_id,
      photos: Photos.list_by_status(:pending))
  end

  def handle_event("photo", %{"id" => clicked}, socket) do
   {:noreply, assign(socket, clicked_photo: clicked )}
  end

  def handle_event("accept", %{"id" => clicked}, socket) do
  {:noreply, accept(clicked, socket)}
  end

  def handle_event("reject", %{"id" => clicked}, socket) do
    IO.inspect clicked
    {:noreply, reject(clicked, socket)}
  end

  def handle_event("send-fake-photo", _value, socket) do
     {:noreply, add_random_photo(socket)}
  end
end
