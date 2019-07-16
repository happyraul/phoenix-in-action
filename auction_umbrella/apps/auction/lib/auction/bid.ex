defmodule Auction.Bid do
  use Ecto.Schema
  import Ecto.Changeset

  map_field = fn field ->
    name = to_string(field)
    if String.ends_with?(name, "_id") do
      "a_" <> String.slice(name, 0..-4)
    else
      "a_" <> name
    end
    |> String.to_atom
  end

  @primary_key {:id, :binary_id, autogenerate: true}
  @field_source_mapper fn f -> map_field.(f) end
  @foreign_key_type :binary_id

  schema "t_bids" do
    field :amount, :integer
    belongs_to :item, Auction.Item
    belongs_to :user, Auction.User
    timestamps()
  end

  def changeset(bid, params \\ %{}) do
    bid
    |> cast(params, [:amount, :user_id, :item_id])
    |> validate_required([:amount, :user_id, :item_id])
    |> assoc_constraint(:item)
    |> assoc_constraint(:user)
  end
end
