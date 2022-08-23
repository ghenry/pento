defmodule Pento.SentrypeerEvents.SentrypeerEvent do
  use Ecto.Schema
  import Ecto.Changeset

  @allowed_fields [
    :app_name,
    :app_version,
    :called_number,
    :collected_method,
    :created_by_node_id,
    :destination_ip,
    :event_timestamp,
    :event_uuid,
    :sip_message,
    :sip_method,
    :sip_user_agent,
    :source_ip,
    :transport_type
  ]

  @derive {Jason.Encoder, only: @allowed_fields}
  schema "sentrypeerevents" do
    field :app_name, :string
    field :app_version, :string
    field :called_number, :string
    field :collected_method, :string
    field :created_by_node_id, :string
    field :destination_ip, :string
    field :event_timestamp, :string
    field :event_uuid, :string
    field :sip_message, :string
    field :sip_method, :string
    field :sip_user_agent, :string
    field :source_ip, :string
    field :transport_type, :string

    timestamps()
  end

  @doc false
  def changeset(sentrypeer_event, attrs) do
    sentrypeer_event
    |> cast(attrs, [
      :app_name,
      :app_version,
      :event_timestamp,
      :event_uuid,
      :created_by_node_id,
      :collected_method,
      :transport_type,
      :source_ip,
      :destination_ip,
      :called_number,
      :sip_method,
      :sip_user_agent,
      :sip_message
    ])
    |> validate_required([
      :app_name,
      :app_version,
      :event_timestamp,
      :event_uuid,
      :created_by_node_id,
      :collected_method,
      :transport_type,
      :source_ip,
      :destination_ip,
      :called_number,
      :sip_method,
      :sip_user_agent,
      :sip_message
    ])
    |> unique_constraint(:event_uuid)
  end
end
