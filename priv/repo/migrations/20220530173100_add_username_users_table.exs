defmodule Pento.Repo.Migrations.CreateUsersAuthTables do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    alter table(:users) do
      add_if_not_exists :username, :citext, default: ""
    end
  end
end
