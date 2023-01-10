defmodule PentoWeb.SentrypeerEventController do
  use PentoWeb, :controller

  alias Pento.SentrypeerEvents
  alias Pento.SentrypeerEvents.SentrypeerEvent

  action_fallback PentoWeb.FallbackController

  def create(conn, sentrypeer_event_params) do
    with {:ok, %SentrypeerEvent{} = sentrypeer_event} <-
           SentrypeerEvents.create_sentrypeer_event(sentrypeer_event_params) do
      conn
      |> put_status(:created)
      |> put_view(MyErrorView)
      |> render(:"201")
    end
  end

end
