# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :git_explorer,
  ecto_repos: [GitExplorer.Repo]

# Configures the endpoint
config :git_explorer, GitExplorerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "TYtyBILhqdaxd5i5iYMXb0Z2RLFJgduYbCO8ouR1JP3flgdjVWOmL0oZfzmlkG3N",
  render_errors: [view: GitExplorerWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: GitExplorer.PubSub,
  live_view: [signing_salt: "3knEyJz/"]

config :git_explorer, GitExplorer.Repositories.Get, git_hub_adapter: GitExplorer.GitHub.Client

config :git_explorer, GitExplorer.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :git_explorer, GitExplorer.Auth.Guardian,
  issuer: "git_explorer",
  secret_key: "9cVnUefPYB0z/SE4uC00G8MnLFRgqwLqNkTfwqkgzFu1LnMP6sBj2EC1wuTeVcU0"

config :git_explorer, GitExplorerWeb.Auth.Pipeline,
  module: GitExplorer.Auth.Guardian,
  error_handler: GitExplorerWeb.Auth.ErrorHandler

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :tesla, adapter: Tesla.Adapter.Hackney

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
