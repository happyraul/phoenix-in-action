defmodule Auction.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :title, :text
      add :description, :text
      add :ends_at, :utc_datetime
      timestamps()
    end
  end
end
