use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :binbase_backend, BinbaseBackendWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :binbase_backend, BinbaseBackend.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "trader",
  password: "trader",
  database: "binbase_backend_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Configures Guardian
config :binbase_backend, BinbaseBackend.Auth.Guardian,
  issuer: "binbase_backend",
  secret_key: "HNinpKh9Ne3tr8BpjCpAEh0xzCqTIG3PWsfkR2AtzvUaRIpbs6oIQ9RcmjmGPekJ"