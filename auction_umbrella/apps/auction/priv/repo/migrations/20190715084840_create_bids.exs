 defmodule Auction.Repo.Migrations.CreateBids do
  use Ecto.Migration

  def change do
    create table(:t_bids) do
      add :a_amount, :integer, null: false
      timestamps(inserted_at: :a_inserted_at, updated_at: :a_updated_at)
    end
  end
end
