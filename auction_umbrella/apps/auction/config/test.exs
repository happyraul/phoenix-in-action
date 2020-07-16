use Mix.Config

config :auction, Auction.Repo,
  database: "auction_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  port: "5432",
  pool: Ecto.Adapters.SQL.Sandbox,
  migration_primary_key: [name: :a_id, type: :binary_id]

config :logger, level: :info
