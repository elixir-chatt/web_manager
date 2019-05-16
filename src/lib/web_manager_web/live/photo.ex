defmodule WebManagerWeb.Photo do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <h1>Welcome to LiveView</h1>
    <h2>The variable value is: <%= @variable %></h2>
    """
  end

  def mount(_session, socket) do
    {:ok, assign(socket, variable: "value")}
  end
end