defmodule EctoTest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      EctoTestWeb.Telemetry,
      EctoTest.Repo,
      {DNSCluster, query: Application.get_env(:ecto_test, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: EctoTest.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: EctoTest.Finch},
      # Start a worker by calling: EctoTest.Worker.start_link(arg)
      # {EctoTest.Worker, arg},
      # Start to serve requests, typically the last entry
      EctoTestWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EctoTest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EctoTestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
