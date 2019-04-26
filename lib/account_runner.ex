defmodule Account.Runner do
  use GenServer

  #
  defp demo() do
    {:ok, account} = Account.start_link()

    account
    |> Account.open(%{account_number: "A-1234", initial_balance: 100})
    |> IO.inspect(label: "opening the account")

    account
    |> Account.deposit_funds(%{amount: 50})
    |> IO.inspect(label: "depositing funds")

    account
    |> Account.withdraw_funds(%{amount: 75})
    |> IO.inspect(label: "withdrawing funds")
  end

  # Client

  @spec start_link(any()) :: :ignore | {:error, any()} | {:ok, pid()}
  def start_link(_args) do
    ok = {:ok, pid} = GenServer.start_link(__MODULE__, %{})
    schedule_run(pid)
    ok
  end

  defp schedule_run(pid) do
    Process.send_after(pid, :run, 500)
    Process.send_after(pid, :shutdown, 1500)
  end

  # Server

  @impl true
  def init(state) do
    {:ok, state}
  end

  #
  @impl true
  def handle_info(:run, state) do
    demo()
    {:noreply, state}
  end

  @impl true
  def handle_info(:shutdown, state) do
    # end of the demo
    System.halt()
    {:noreply, state}
  end
end
