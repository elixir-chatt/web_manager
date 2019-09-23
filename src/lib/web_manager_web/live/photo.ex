defmodule WebManagerWeb.Photo do
  use Phoenix.LiveView
  alias WebManager.Photos

  def render(assigns) do
    ~L"""
    <section class="phx-hero">
      <h1>Submitted Pictures from our Photobooth by <%= @person.name %></h1>
      <div class="row">

          <%= render_photos(@photos) |> Phoenix.HTML.raw %>

      </div>
    </section>
    <h1><span class="green-text">PhotoID Accepted:</span> <%= @accepted_photo_id%>
    <span class="red-text">PhotoID Rejected:</span> <%= @rejected_photo_id%> </h1>
    <section>
          <form method="POST" action="uploadFile" enctype="multipart/form-data">
          <strong>Upload file:</strong>
          <input type="file" name="file" />
              <input type="submit" value="Upload" />
          </form>
          <a href="#" class="btn" phx-click="send-fake-photo">Send fake photo</a>
    </section>
    """
  end

  def mount(_session, socket) do
    {
      :ok,
      assign(
        socket,
        person: %{name: "---"},
        photos: Photos.list_by_status(:pending),
        clicked_photo: "---",
        accepted_photo_id: "---",
        rejected_photo_id: "---")
      }
  end

  def add_random_photo(socket) do
    Photos.create(
      %{
        path: "#{:random.uniform(5)}.jpg",
        status: "pending",
        troll: false
      }
    )

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
      <a href="#" phx-click="photo" phx-value="#{photo.id}" class="thumbnail">
        <img height=100 src="/images/#{photo.path}" />
      </a>
      <div class="btns">
        <button href="#" phx-click="reject" phx-value="#{photo.id}" id="reject" class="btn btn-reject">👎</button>
        <button href="#" phx-click="accept" phx-value="#{photo.id}" id="accept" class="btn btn-accept">👍</button>
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

  def handle_event("photo", clicked, socket) do
   {:noreply, assign(socket, clicked_photo: clicked )}
  end

  def handle_event("accept", clicked, socket) do
  {:noreply, accept(clicked, socket)}
  end

  def handle_event("reject", clicked, socket) do
    {:noreply, reject(clicked, socket)}
  end

  def handle_event("send-fake-photo", _value, socket) do
     {:noreply, add_random_photo(socket)}
  end
end
