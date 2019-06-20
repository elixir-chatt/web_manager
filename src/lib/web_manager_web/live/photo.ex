defmodule WebManagerWeb.Photo do
  use Phoenix.LiveView
  alias WebManager.Repo

  import Ecto
  import Ecto.Changeset
  import Ecto.Query

  def render(assigns) do
    ~L"""
    <svg
     version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
      preserveAspectRatio="xMidYMid meet" viewBox="0 0 800 100" width="800" height="100">
    <rect id="svg_1" height="84" width="<%= @wid %>" y="10" x="10" stroke-width="5" stroke="#000000" fill="#FF0000"/>
    </svg>
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

    """
  end

  def mount(_session, socket) do
    {:ok, assign(socket, person: %{name: "Grace"}, photos: photos(),
    clicked_photo: "---", wid: 150)}
  end

  def photos() do
    [
      photo("1.jpg", 1), photo("2.jpg", 2),photo("1.jpg", 3), photo("2.jpg", 4)
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
    from(t in "test", where: t.sample == ^clicked) |> WebManager.Repo.delete_all
    WebManager.Repo.insert_all("test", [%{sample: clicked}])


    #mysample = List.first([%{sample: "test"}])|>Map.get(:sample, "nothing")
   {:noreply, assign(socket, clicked_photo: clicked, wid: 10*:rand.uniform(60) )}
  end
end
