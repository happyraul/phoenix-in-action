defmodule Auction.Item do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @field_source_mapper fn f -> String.to_atom("a_" <> to_string(f)) end

  schema "t_items" do
    field :title, :string
    field :description, :string
    field :ends_at, :utc_datetime
    has_many :bids, Auction.Bid
    timestamps()
  end

  def changeset(item, params \\ %{}) do
    item
    |> cast(params, [:title, :description, :ends_at])
    |> validate_required(:title)
    |> validate_length(:title, min: 3, max: 100)
    |> validate_length(:description, max: 200)
    |> validate_change(:ends_at, &validate/2)
  end

  defp validate(:ends_at, ends_at_date) do
    case DateTime.compare(ends_at_date, DateTime.utc_now()) do
      :lt -> [ends_at: "Auction end date cannot be in the past"]
      _ -> []
    end
  end
end
