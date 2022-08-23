defmodule Pento.SentrypeerEventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pento.SentrypeerEvents` context.
  """

  @doc """
  Generate a unique sentrypeer_event event_uuid.
  """
  def unique_sentrypeer_event_event_uuid,
    do: "some event_uuid#{System.unique_integer([:positive])}"

  @doc """
  Generate a sentrypeer_event.
  """
  def sentrypeer_event_fixture(attrs \\ %{}) do
    {:ok, sentrypeer_event} =
      attrs
      |> Enum.into(%{
        app_name: "some app_name",
        app_version: "some app_version",
        called_number: "some called_number",
        collected_method: "some collected_method",
        created_by_node_id: "some created_by_node_id",
        destination_ip: "some destination_ip",
        event_timestamp: "some event_timestamp",
        event_uuid: unique_sentrypeer_event_event_uuid(),
        sip_message: "some sip_message",
        sip_method: "some sip_method",
        sip_user_agent: "some sip_user_agent",
        source_ip: "some source_ip",
        transport_type: "some transport_type"
      })
      |> Pento.SentrypeerEvents.create_sentrypeer_event()

    sentrypeer_event
  end
end
