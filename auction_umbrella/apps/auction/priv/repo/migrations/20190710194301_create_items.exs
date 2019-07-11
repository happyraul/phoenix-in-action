defmodule Auction.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table("t_items", primary_key: false) do
      add :a_id, :uuid, primary_key: true
      add :a_title, :text
      add :a_description, :text
      add :a_ends_at, :utc_datetime
      timestamps(inserted_at: :a_inserted_at, updated_at: :a_updated_at)
    end
  end
end
