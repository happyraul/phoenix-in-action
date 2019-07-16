defmodule AuctionWeb.Authenticator do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    result =
      conn
      |> get_session(:user_id)
      |> case do
        nil -> nil
        id -> Auction.find_user(id)
      end
    case result do
      nil -> assign(conn, :current_user, nil)
      user -> assign(conn, :current_user, user)
    end
  end
end
