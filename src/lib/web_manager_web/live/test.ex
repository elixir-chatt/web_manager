defmodule WebManagerWeb.TestLive do
  use Phoenix.LiveView
  @chars ["Josue","Jon","Bret"]
  def render(assigns) do
    ~L"""
    <h1>Hello, <%= @msg %>!</h1>
    <p>This is a paragraph.</p>
    <p>This is another paragraph.</p>
    """
  end

  def mount(_session, socket) do
    if connected?(socket), do: :timer.send_interval(1000, self(), :tick)

    {:ok, put_msg(socket)}
  end

  defp put_msg(socket) do
    assign(socket, msg: Enum.random(@chars))
  end

end
