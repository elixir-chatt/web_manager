defmodule WebManager.PhotoService do
  def accept(photo) do
    %{photo | status: "accepted"}
  end

  def reject(photo) do
    %{photo | status: "rejected"}
  end
end
