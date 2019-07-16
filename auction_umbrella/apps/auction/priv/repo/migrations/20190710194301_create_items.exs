defmodule Auction.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:t_items) do
      add :a_title, :text, null: false
      add :a_description, :text
      add :a_ends_at, :utc_datetime, null: false
      timestamps(inserted_at: :a_inserted_at, updated_at: :a_updated_at)
    end
  end
end
