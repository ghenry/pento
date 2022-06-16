defmodule Pento.Repo.Migrations.CreateFaqs do
  use Ecto.Migration

  def change do
    create table(:faqs) do
      add :question, :string
      add :answer, :string
      add :upvote_count, :integer

      timestamps()
    end
  end
end
