defmodule Auction.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:t_users, primary_key: false) do
      add :a_id, :uuid, primary_key: true
      add :a_username, :text
      add :a_email_address, :text
      add :a_hashed_password, :text
      timestamps(inserted_at: :a_inserted_at, updated_at: :a_updated_at)
    end

    create unique_index(:t_users, [:a_username])
  end
end
