defmodule WebManagerWeb.Photo do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <section class="phx-hero">
      <h1>Submited Pictures from <%= @person.name %></h1>
      <div class="row">
        <div class="col-xs-6 col-md-3">
          <%= render_photos(@photos) |> Phoenix.HTML.raw %>
        </div>
      </div>
    </section>
    <h1><%= @clicked_photo %></h1>
    <section>
          <form method="POST" action="uploadFile" enctype="multipart/form-data">
          <strong>Upload file:</strong> 
          <input type="file" name="file" />
              <input type="submit" value="Upload" />
          </form>

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
    {:ok, assign(socket, person: %{name: "Grace"}, photos: photos(), clicked_photo: "---")}
  end
  
  def photos() do
    [
      photo("1.jpg", 1), photo("2.jpg", 2)
    ]
  end
  
  def photo(path, id), do: %{path: path, id: id}
  
  def render_photos(photos) do
    photos
    |> Enum.map(&render_photo/1)
  end
    
  def render_photo(photo) do
    """
    <a href="#" phx-click="photo" phx-value="photo#{photo.id}" class="thumbnail">
      <img height=100 src="/images/#{photo.path}" />
    </a>
    """
  end
  
  def handle_event("photo", clicked, socket) do
   {:noreply, assign(socket, clicked_photo: clicked )}
  end
end