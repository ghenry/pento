defmodule Pento.FrequestAskedQuestions.FAQ do
  use Ecto.Schema
  import Ecto.Changeset

  schema "faqs" do
    field :answer, :string
    field :question, :string
    field :upvote_count, :integer

    timestamps()
  end

  @doc false
  def changeset(faq, attrs) do
    faq
    |> cast(attrs, [:question, :answer, :upvote_count])
    |> validate_required([:question, :answer, :upvote_count])
  end
end
