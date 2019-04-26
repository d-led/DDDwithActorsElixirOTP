defmodule Account do
  use GenServer

  # Client

  def start_link(_args \\ []) do
    GenServer.start_link(__MODULE__, [])
  end

  def open(pid, req) do
    GenServer.call(pid, {:open, req})
  end

  def deposit_funds(pid, req) do
    GenServer.call(pid, {:deposit_funds, req})
  end

  def withdraw_funds(pid, req) do
    GenServer.call(pid, {:withdraw_funds, req})
  end

  # Server (callbacks)

  @impl true
  def init(_args) do
    {:ok, :uninitialized_state}
  end

  @impl true
  def handle_call(
        {:open, %{account_number: account_number, initial_balance: initial_balance}},
        _from,
        :uninitialized_state
      ) do
    state = %{
      account_number: account_number,
      balance: initial_balance
    }

    {:reply, {:account_opened, state: state}, state}
  end

  @impl true
  def handle_call(
        {:deposit_funds, %{amount: amount}},
        _from,
        state = %{}
      ) do
    state = %{state | balance: state.balance + amount}
    {:reply, {:funds_deposited, state: state, amount_deposited: amount}, state}
  end

  @impl true
  def handle_call(
        {:withdraw_funds, %{amount: amount}},
        _from,
        state = %{}
      ) do
    state = %{state | balance: state.balance - amount}
    {:reply, {:funds_withdrawn, state: state, amount_withdrawn: amount}, state}
  end
end
