defmodule Demo do
  use Application

  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: Demo.Supervisor]

    children = [
      Account.Runner
    ]

    Supervisor.start_link(children, opts)
  end
end
