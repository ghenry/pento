defmodule PentoWeb.SentrypeerEventView do
  use PentoWeb, :view
  alias PentoWeb.SentrypeerEventView

  def render("index.json", %{sentrypeerevents: sentrypeerevents}) do
    %{data: render_many(sentrypeerevents, SentrypeerEventView, "sentrypeer_event.json")}
  end

  def render("show.json", %{sentrypeer_event: sentrypeer_event}) do
    %{data: render_one(sentrypeer_event, SentrypeerEventView, "sentrypeer_event.json")}
  end

  def render("sentrypeer_event.json", %{sentrypeer_event: sentrypeer_event}) do
    %{
      id: sentrypeer_event.id,
      app_name: sentrypeer_event.app_name,
      app_version: sentrypeer_event.app_version,
      event_timestamp: sentrypeer_event.event_timestamp,
      event_uuid: sentrypeer_event.event_uuid,
      created_by_node_id: sentrypeer_event.created_by_node_id,
      collected_method: sentrypeer_event.collected_method,
      transport_type: sentrypeer_event.transport_type,
      source_ip: sentrypeer_event.source_ip,
      destination_ip: sentrypeer_event.destination_ip,
      called_number: sentrypeer_event.called_number,
      sip_method: sentrypeer_event.sip_method,
      sip_user_agent: sentrypeer_event.sip_user_agent,
      sip_message: sentrypeer_event.sip_message
    }
  end
end
