defmodule Contai.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Contai.Repo,
      # Start the Telemetry supervisor
      ContaiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Contai.PubSub},
      # Start the Endpoint (http/https)
      ContaiWeb.Endpoint
      # Start a worker by calling: Contai.Worker.start_link(arg)
      # {Contai.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Contai.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ContaiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
