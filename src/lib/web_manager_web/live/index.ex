defmodule WebManagerWeb.Index do
  use Phoenix.LiveView
  alias WebManager.Photos

  def render(assigns) do
    ~L"""
    <section class="phx-hero">
      <h1>Photo Data Dump</h1>
      <div class="row">

          <%= render_photos(@photos) |> Phoenix.HTML.raw %>

      </div>
    </section>
    

    """
  end

  def mount(_session, socket) do
    {
      :ok,
      assign(
        socket,
        photos: Photos.list_by_status(:all))
      }
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
    #{status_icon(photo)}
    </div>
    """
  end

  def status_icon(%{status: "accepted"}=photo) do
    """
    <button href="#" phx-click="accept" phx-value="#{photo.id}" id="accept" class="btn btn-accept">👍</button>
    </div>
    </div>
    """
  end
  def status_icon(%{status: "rejected"}=photo) do
      """
      <button href="#" phx-click="reject" phx-value="#{photo.id}" id="reject" class="btn btn-reject">👎</button>
      </div>
      </div>
      """
  end
end



