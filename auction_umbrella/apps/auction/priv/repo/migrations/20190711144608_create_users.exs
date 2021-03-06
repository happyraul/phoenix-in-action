defmodule Auction.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:t_users) do
      add :a_username, :text, null: false
      add :a_email_address, :text, null: false
      add :a_hashed_password, :text, null: false
      timestamps(inserted_at: :a_inserted_at, updated_at: :a_updated_at)
    end

    create unique_index(:t_users, [:a_username])
  end
end
