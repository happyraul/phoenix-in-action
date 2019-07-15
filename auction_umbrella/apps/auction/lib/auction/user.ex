defmodule Auction.User do
  import Ecto.Changeset
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @field_source_mapper fn f -> String.to_atom("a_" <> to_string(f)) end

  schema "t_users" do
    field :username, :string
    field :email_address, :string
    field :password, :string, virtual: true
    field :hashed_password, :string
    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:username, :email_address])
    |> validate_required([:username, :email_address, :hashed_password])
    |> validate_length(:username, min: 16)
    |> lower_username()
    |> lower_email()
    |> unique_constraint(:username)
  end

  def changeset_with_password(user, params \\ %{}) do
    user
    |> cast(params, [:password])
    |> validate_required(:password)
    |> validate_length(:password, min: 16)
    |> validate_confirmation(:password, required: true)
    |> hash_password()
    |> changeset(params)
  end

  defp hash_password(%Ecto.Changeset{changes: %{password: password}} =
   changeset) do
    changeset
    |> put_change(:hashed_password, Auction.Password.hash(password))
  end
  defp hash_password(changeset), do: changeset

  defp lower_username(%Ecto.Changeset{changes: %{username: username}} =
   changeset) do
     changeset
     |> put_change(:username, String.downcase(username))
  end
  defp lower_username(changeset), do: changeset

  defp lower_email(%Ecto.Changeset{changes: %{email_address: email_address}} =
   changeset) do
     changeset
     |> put_change(:email_address, String.downcase(email_address))
  end
  defp lower_email(changeset), do: changeset
end
