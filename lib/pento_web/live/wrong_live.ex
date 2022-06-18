defmodule PentoWeb.WrongLive do
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}
  require Logger

  alias Pento.Accounts

  def mount(_params, session, socket) do
    Logger.info("Mounting WrongLive")

    {
      :ok,
      assign(
        socket,
        score: 0,
        message: "Make a guess (from 1 to 10):",
        session_id: session["live_socket_id"],
        current_time: time(),
        random_number: :rand.uniform(10)
      )
    }
  end

  def handle_event("guess", %{"number" => guess} = _data, socket) do
    message = "Your guess: #{guess}. Wrong. Guess again. "
    score = socket.assigns.score - 1
    current_time = time()
    random_number = socket.assigns.random_number
    Logger.info("Guess is: #{inspect(guess)}")
    Logger.info("WrongLive Random Number is: #{random_number}")

    if String.to_integer(guess) == random_number do
      Logger.info("WrongLive guess is correct. Generating new random number.")
      message = "Your guess: #{guess}. Correct! "
      score = socket.assigns.score + 1

      {
        :noreply,
        assign(socket,
          score: score,
          message: message,
          current_time: current_time,
          random_number: :rand.uniform(10)
        )
      }
    else
      {
        :noreply,
        assign(
          socket,
          message: message,
          score: score,
          current_time: current_time
        )
      }
    end
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
    <%= @message %>
    It's <%= @current_time %>
    </h2>
    <h2>
    <%= for n <- 1..10 do %>
    <a href="#" phx-click="guess" phx-value-number= {n} ><%= n %></a>
    <% end %>
    </h2>
    """
  end

  defp time() do
    # DateTime.utc_now |> to_string
    Calendar.strftime(DateTime.utc_now(), "%y-%m-%d %I:%M:%S %p")
  end
end
