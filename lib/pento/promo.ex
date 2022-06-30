defmodule Pento.Promo do
  @moduledoc false
  import Swoosh.Email
  alias Pento.Promo.Recipient
  alias Pento.Mailer

  def change_recipient(%Recipient{} = recipient, attrs \\ %{}) do
    Recipient.changeset(recipient, attrs)
  end

  def send_promo(recipient, _attrs) do
    # send email to promo recipient
    deliver_promo_code(recipient)
    {:ok, %Recipient{}}
  end

  # Delivers the email using the application mailer.
  defp deliver(recipient, subject, body) do
    email_from = "sales@" <> System.get_env("PENTO_SENDGRID_DOMAIN") || "example.com"

    email =
      new()
      |> to(recipient)
      |> from({"Pento Sales", email_from})
      |> subject(subject)
      |> text_body(body)

    with {:ok, _metadata} <- Mailer.deliver(email) do
      {:ok, email}
    end
  end

  @doc """
  Deliver instructions to confirm account.
  """
  def deliver_promo_code(user) do
    deliver(
      user["email"],
      "Pento Promo Code",
      """

      ==============================

      Hi #{user["first_name"]},

      You can use your promo code by visiting the following link:

      #{System.get_env("PENTO_PROMO_URL")}

      Thanks,
      Pento Support
      ==============================
      """
    )
  end
end
