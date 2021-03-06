defmodule PentoWeb.PromoLive do
  @moduledoc false

  use PentoWeb, :live_view
  alias Pento.Promo
  alias Pento.Promo.Recipient

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_recipient()
     |> assign_changeset()}
  end

  def assign_recipient(socket) do
    socket
    |> assign(:recipient, %Recipient{})
  end

  def assign_changeset(%{assigns: %{recipient: recipient}} = socket) do
    socket
    |> assign(:changeset, Promo.change_recipient(recipient))
  end

  def handle_event(
        "validate",
        %{"recipient" => recipient_params},
        %{assigns: %{recipient: recipient}} = socket
      ) do
    changeset =
      recipient
      |> Promo.change_recipient(recipient_params)
      |> Map.put(:action, :validate)

    {:noreply,
     socket
     |> assign(:changeset, changeset)}
  end

  def handle_event(
        "save",
        %{"recipient" => recipient_params},
        socket
      ) do
    # Slow it down a bit to make sure the user sees the save button disappear.
    :timer.sleep(3000)

    # Call email service and email code
    case Promo.send_promo(recipient_params, socket) do
      {:ok, _} ->
        {:noreply,
         socket
         |> put_flash(:info, "Promo code sent successfully!")
         |> assign(:recipient, %Recipient{})}

      {_, _} ->
        {:noreply,
         socket
         |> put_flash(:error, "Error sending promo code!")}
    end
  end
end
