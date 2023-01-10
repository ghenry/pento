defmodule PentoWeb.SentrypeerEventController do
  use PentoWeb, :controller

  alias Pento.SentrypeerEvents
  alias Pento.SentrypeerEvents.SentrypeerEvent

  action_fallback PentoWeb.FallbackController

  def index(conn, _params) do
    sentrypeerevents = SentrypeerEvents.list_sentrypeerevents()
    render(conn, "index.json", sentrypeerevents: sentrypeerevents)
  end

  def create(conn, sentrypeer_event_params) do
    with {:ok, %SentrypeerEvent{} = sentrypeer_event} <-
           SentrypeerEvents.create_sentrypeer_event(sentrypeer_event_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.sentrypeer_event_path(conn, :show, sentrypeer_event_params["account_uuid"], sentrypeer_event))
      |> render("show.json", sentrypeer_event: sentrypeer_event)
    end
  end

  def show(conn, %{"id" => id}) do
    sentrypeer_event = SentrypeerEvents.get_sentrypeer_event!(id)
    render(conn, "show.json", sentrypeer_event: sentrypeer_event)
  end
end
