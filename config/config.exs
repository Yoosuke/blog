# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :blog,
  ecto_repos: [Blog.Repo]

# Configures the endpoint
config :blog, BlogWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "v+dNxPeCHnFWGsHDxNWV2HPkz/BDrfqFNCaKR2JWpk59sgY3mcq6hRLhs1Shhufg",
  render_errors: [view: BlogWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Blog.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# Guardian config
config :blog, Blog.Guardian,
       issuer: "blog",
secret_key: "+Vvet3YfOyjBs/6ayVqWWS9hhG1Lh/IVDf3FAJjhumRKd0FoYYEgCptqHzv36jth"
