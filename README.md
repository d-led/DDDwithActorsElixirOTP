# DDDwithActorsElixirOTP

[![Build Status](https://travis-ci.org/d-led/DDDwithActorsElixirOTP.svg?branch=master)](https://travis-ci.org/d-led/DDDwithActorsElixirOTP)

Elixir/OTP version of https://github.com/VaughnVernon/DDDwithActors by Vaughn Vernon

## Running

```text
mix compile
mix run --no-halt
```

&darr;

```text
opening the account: {:account_opened, [state: %{account_number: "A-1234", balance: 100}]}
depositing funds: {:funds_deposited,
 [state: %{account_number: "A-1234", balance: 150}, amount_deposited: 50]}
withdrawing funds: {:funds_withdrawn,
 [state: %{account_number: "A-1234", balance: 75}, amount_withdrawn: 75]}
```

## Code Structure

- [lib/demo.ex](lib/demo.ex) starts `Account.Runner` as a supervised process
- [lib/account_runner.ex](lib/account_runner.ex)
  - schedules the demo run and the run-time shutdown after 1.5 seconds (for demo/CI purposes)
  - starts an `Account` process and interacts with it
- [lib/account.ex](lib/account.ex) implements the `Account` logic wrapped into a [`GenServer`](https://hexdocs.pm/elixir/GenServer.html)
