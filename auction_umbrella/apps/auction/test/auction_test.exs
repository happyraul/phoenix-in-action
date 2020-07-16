defmodule AuctionTest do
  use ExUnit.Case
  import Ecto.Query
  alias Auction.{Item, Repo}
  doctest Auction, import: true

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  describe "list_items/0" do
    setup do
      {:ok, item1} = Repo.insert(%Item{
        title: "Item 1",
        ends_at: DateTime.from_naive!(~N[2020-01-01 02:00:00], "Etc/UTC")
      })
      {:ok, item2} = Repo.insert(%Item{
        title: "Item 2",
        ends_at: DateTime.from_naive!(~N[2020-01-01 02:00:00], "Etc/UTC")
      })
      {:ok, item3} = Repo.insert(%Item{
        title: "Item 3",
        ends_at: DateTime.from_naive!(~N[2020-01-01 02:00:00], "Etc/UTC")
      })
      %{items: [item1, item2, item3]}
    end

    test "returns all Items in the database", %{items: items} do
      assert items == Auction.list_items
    end
  end

  describe "get_item/1" do
    setup do
      {:ok, item1} = Repo.insert(%Item{
        title: "Item 1",
        ends_at: DateTime.from_naive!(~N[2020-01-01 02:00:00], "Etc/UTC")
      })
      {:ok, item2} = Repo.insert(%Item{
        title: "Item 2",
        ends_at: DateTime.from_naive!(~N[2020-01-01 02:00:00], "Etc/UTC")
      })
      %{items: [item1, item2]}
    end

    test "returns a single Item based on id", %{items: items} do
      item = Enum.at(items, 1)
      assert item == Auction.get_item(item.id)
    end
  end

  describe "insert_item/1" do
    test "adds an Item to the database" do
      count_query = from i in Item, select: count(i.id)
      before_count = Repo.one(count_query)
      {:ok, _item} = Auction.insert_item(%{
        title: "test item",
        ends_at: DateTime.from_naive!(~N[2020-01-01 02:00:00], "Etc/UTC")
      })
      assert Repo.one(count_query) == before_count + 1
    end

    test "the Item in the database has the attributes provided" do
      attrs = %{
        title: "test item", description: "test description",
        ends_at: DateTime.from_naive!(~N[2020-01-01 02:00:00], "Etc/UTC")
      }
      {:ok, item} = Auction.insert_item(attrs)
      assert item.title == attrs.title
      assert item.description == attrs.description
      assert item.ends_at == attrs.ends_at
    end

    test "it returns an error on error" do
      assert {:error, _changeset} = Auction.insert_item(%{foo: :bar})
    end
  end
end
