defmodule WebManagerWeb.Photo do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <section class="phx-hero">
      <h1>Submitted Pictures from our Photobooth by <%= @person.name %></h1>
      <div class="row">

          <%= render_photos(@photos) |> Phoenix.HTML.raw %>

      </div>
    </section>
    <h1>accepted: <%= @accepted_photo_id%>
    rejected: <%= @rejected_photo_id%> </h1>
    <section>
          <form method="POST" action="uploadFile" enctype="multipart/form-data">
          <strong>Upload file:</strong>
          <input type="file" name="file" />
              <input type="submit" value="Upload" />
          </form>
          <a href="#" class="btn" phx-click="send-fake-photo">Send fake photo</a>
    </section>
    <section class="row">
      <article class="column">
        <h2>Resources</h2>
        <ul>
          <li>
            <a href="https://hexdocs.pm/phoenix/overview.html">Guides &amp; Docs</a>
          </li>
          <li>
            <a href="https://github.com/phoenixframework/phoenix">Source</a>
          </li>
          <li>
            <a href="https://github.com/phoenixframework/phoenix/blob/v1.4/CHANGELOG.md">v1.4 Changelog</a>
          </li>
        </ul>
      </article>
      <article class="column">
        <h2>Help</h2>
        <ul>
          <li>
            <a href="https://elixirforum.com/c/phoenix-forum">Forum</a>
          </li>
          <li>
            <a href="https://webchat.freenode.net/?channels=elixir-lang">#elixir-lang on Freenode IRC</a>
          </li>
          <li>
            <a href="https://twitter.com/elixirphoenix">Twitter @elixirphoenix</a>
          </li>
        </ul>
      </article>
    </section>
    """
  end

  def mount(_session, socket) do
    {
      :ok,
      assign(
        socket,
        person: %{name: "Lucas"},
        photos: photos(),
        clicked_photo: "---",
        accepted_photo_id: "---",
        rejected_photo_id: "---")
      }
  end

  def photos() do
    []
  end

  def photo(path, id), do: %{path: path, id: id}

  def random_photo() do
    number = :random.uniform(5)
    %{path: "#{number}.jpg", id: number}
  end

  def add_random_photo(socket) do
    photos = socket.assigns.photos
    assign(socket, :photos, [random_photo()|photos])
  end

  def render_photos(photos) do
    photos
    |> Enum.map(&render_photo/1)
  end

  def render_photo(photo) do
    """
    <div class="img-container">
      <a href="#" phx-click="photo" phx-value="photo#{photo.id}" class="thumbnail">
        <img height=100 src="/images/#{photo.path}" />
      </a>
      <div class="btns">
        <button href="#" phx-click="reject" phx-value="photo#{photo.id}" id="reject" class="btn btn-reject">👎</button>
        <button href="#" phx-click="accept" phx-value="photo#{photo.id}" id="accept" class="btn btn-accept">👍</button>
      </div>
    </div>
    """
  end

  def accept(clicked, socket) do
    assign(socket, accepted_photo_id: clicked)
  end

  def reject(clicked, socket) do
    assign(socket, rejected_photo_id: clicked)
  end

  def handle_event("photo", clicked, socket) do
   {:noreply, assign(socket, clicked_photo: clicked )}
  end

  def handle_event("accept", clicked, socket) do
  {:noreply, accept(clicked, socket) |> IO.inspect}
  end

  def handle_event("reject", clicked, socket) do
    {:noreply, reject(clicked, socket)}
  end

  def handle_event("send-fake-photo", clicked, socket) do
     {:noreply, add_random_photo(socket)}
  end



end
