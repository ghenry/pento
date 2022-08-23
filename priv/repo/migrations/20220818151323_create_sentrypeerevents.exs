defmodule Pento.Repo.Migrations.CreateSentrypeerevents do
  use Ecto.Migration

  def change do
    create table(:sentrypeerevents) do
      add :app_name, :string
      add :app_version, :string
      add :event_timestamp, :string
      add :event_uuid, :string
      add :created_by_node_id, :string
      add :collected_method, :string
      add :transport_type, :string
      add :source_ip, :string
      add :destination_ip, :string
      add :called_number, :string
      add :sip_method, :string
      add :sip_user_agent, :string
      add :sip_message, :string

      timestamps()
    end

    create unique_index(:sentrypeerevents, [:event_uuid])
  end
end
