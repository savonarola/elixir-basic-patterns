defmodule BadLookingCode do
  use GenServer

  def handle_call({:event, url, bucket}, _from, state) do
    state = if state.current_bucket do
      delete_current_bucket(state)
      new_bucket = %{prefix: "events", data: []}
      %{state | current_bucket: new_bucket}
    else
      state
    end

    state = set_new_listeners(state)

    if good_url?(state, url) do
      hooks = before_hooks(state, url)

      good_hooks = hooks
      |> Enum.map(&("act_#{&1}"))
      |> Enum.filter(&(!Regex.match?(&1, ~r/\d{4}-\d{2}-\d{2}/)))
      |> eval_hook(true)

      Logger.info("Good before hooks: #{inspect good_hooks}")

      hooks = after_hooks(state, url)

      good_hooks = hooks
      |> Enum.map(&("act_#{&1}_a"))
      |> Enum.filter(&(!Regex.match?(&1, ~r/\d{4}-\d{2}-\d{2}/)))
      |> eval_hook(true)

      Logger.info("Good after hooks: #{inspect good_hooks}")
      {:reply, {good_hooks, url}, state}
    else
      {:reply, bucket, state}
    end
  end
end
