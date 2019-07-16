defmodule Auction.Repo.Migrations.AddAssociationToBids do
  use Ecto.Migration

  def change do
    alter table(:t_bids) do
      add :a_item, references(:t_items, column: :a_id), null: false
      add :a_user, references(:t_users, column: :a_id), null: false
    end

    create index(:t_bids, [:a_item])
    create index(:t_bids, [:a_user])
    create index(:t_bids, [:a_item, :a_user])
  end
end
