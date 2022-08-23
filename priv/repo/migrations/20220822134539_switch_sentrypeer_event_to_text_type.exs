defmodule Pento.Repo.Migrations.SwitchSentrypeerEventToTextType do
  use Ecto.Migration

  def change do
    alter table(:sentrypeerevents) do
      modify :app_name, :text
      modify :app_version, :text
      modify :event_timestamp, :text
      modify :event_uuid, :text
      modify :created_by_node_id, :text
      modify :collected_method, :text
      modify :transport_type, :text
      modify :source_ip, :text
      modify :destination_ip, :text
      modify :called_number, :text
      modify :sip_method, :text
      modify :sip_user_agent, :text
      modify :sip_message, :text
    end
  end
end
