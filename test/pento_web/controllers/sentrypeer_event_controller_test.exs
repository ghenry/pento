defmodule PentoWeb.SentrypeerEventControllerTest do
  use PentoWeb.ConnCase

  import Pento.SentrypeerEventsFixtures

  alias Pento.SentrypeerEvents.SentrypeerEvent

  @create_attrs %{
    app_name: "some app_name",
    app_version: "some app_version",
    called_number: "some called_number",
    collected_method: "some collected_method",
    created_by_node_id: "some created_by_node_id",
    destination_ip: "some destination_ip",
    event_timestamp: "some event_timestamp",
    event_uuid: "some event_uuid",
    sip_message: "some sip_message",
    sip_method: "some sip_method",
    sip_user_agent: "some sip_user_agent",
    source_ip: "some source_ip",
    transport_type: "some transport_type"
  }
  @update_attrs %{
    app_name: "some updated app_name",
    app_version: "some updated app_version",
    called_number: "some updated called_number",
    collected_method: "some updated collected_method",
    created_by_node_id: "some updated created_by_node_id",
    destination_ip: "some updated destination_ip",
    event_timestamp: "some updated event_timestamp",
    event_uuid: "some updated event_uuid",
    sip_message: "some updated sip_message",
    sip_method: "some updated sip_method",
    sip_user_agent: "some updated sip_user_agent",
    source_ip: "some updated source_ip",
    transport_type: "some updated transport_type"
  }
  @invalid_attrs %{
    app_name: nil,
    app_version: nil,
    called_number: nil,
    collected_method: nil,
    created_by_node_id: nil,
    destination_ip: nil,
    event_timestamp: nil,
    event_uuid: nil,
    sip_message: nil,
    sip_method: nil,
    sip_user_agent: nil,
    source_ip: nil,
    transport_type: nil
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all sentrypeerevents", %{conn: conn} do
      conn = get(conn, Routes.sentrypeer_event_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create sentrypeer_event" do
    test "renders sentrypeer_event when data is valid", %{conn: conn} do
      conn =
        post(conn, Routes.sentrypeer_event_path(conn, :create), sentrypeer_event: @create_attrs)

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.sentrypeer_event_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "app_name" => "some app_name",
               "app_version" => "some app_version",
               "called_number" => "some called_number",
               "collected_method" => "some collected_method",
               "created_by_node_id" => "some created_by_node_id",
               "destination_ip" => "some destination_ip",
               "event_timestamp" => "some event_timestamp",
               "event_uuid" => "some event_uuid",
               "sip_message" => "some sip_message",
               "sip_method" => "some sip_method",
               "sip_user_agent" => "some sip_user_agent",
               "source_ip" => "some source_ip",
               "transport_type" => "some transport_type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn =
        post(conn, Routes.sentrypeer_event_path(conn, :create), sentrypeer_event: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update sentrypeer_event" do
    setup [:create_sentrypeer_event]

    test "renders sentrypeer_event when data is valid", %{
      conn: conn,
      sentrypeer_event: %SentrypeerEvent{id: id} = sentrypeer_event
    } do
      conn =
        put(conn, Routes.sentrypeer_event_path(conn, :update, sentrypeer_event),
          sentrypeer_event: @update_attrs
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.sentrypeer_event_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "app_name" => "some updated app_name",
               "app_version" => "some updated app_version",
               "called_number" => "some updated called_number",
               "collected_method" => "some updated collected_method",
               "created_by_node_id" => "some updated created_by_node_id",
               "destination_ip" => "some updated destination_ip",
               "event_timestamp" => "some updated event_timestamp",
               "event_uuid" => "some updated event_uuid",
               "sip_message" => "some updated sip_message",
               "sip_method" => "some updated sip_method",
               "sip_user_agent" => "some updated sip_user_agent",
               "source_ip" => "some updated source_ip",
               "transport_type" => "some updated transport_type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, sentrypeer_event: sentrypeer_event} do
      conn =
        put(conn, Routes.sentrypeer_event_path(conn, :update, sentrypeer_event),
          sentrypeer_event: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete sentrypeer_event" do
    setup [:create_sentrypeer_event]

    test "deletes chosen sentrypeer_event", %{conn: conn, sentrypeer_event: sentrypeer_event} do
      conn = delete(conn, Routes.sentrypeer_event_path(conn, :delete, sentrypeer_event))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.sentrypeer_event_path(conn, :show, sentrypeer_event))
      end
    end
  end

  defp create_sentrypeer_event(_) do
    sentrypeer_event = sentrypeer_event_fixture()
    %{sentrypeer_event: sentrypeer_event}
  end
end
