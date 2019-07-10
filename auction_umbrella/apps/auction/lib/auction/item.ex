defmodule Auction.Item do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "items" do
  	field :title, :string
  	field :description, :string
  	field :ends_at, :utc_datetime
  	timestamps()
  end
end
