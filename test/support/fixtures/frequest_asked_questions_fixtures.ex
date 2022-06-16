defmodule Pento.FrequestAskedQuestionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pento.FrequestAskedQuestions` context.
  """

  @doc """
  Generate a faq.
  """
  def faq_fixture(attrs \\ %{}) do
    {:ok, faq} =
      attrs
      |> Enum.into(%{
        answer: "some answer",
        question: "some question",
        upvote_count: 42
      })
      |> Pento.FrequestAskedQuestions.create_faq()

    faq
  end
end
