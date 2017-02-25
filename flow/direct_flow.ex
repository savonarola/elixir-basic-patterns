defmodule EventReceiver do
  def handle(event) do
    event
    |> Handler0.handle()
    |> Handler1.handle()
  end

  def start do
    GenServer.start_link(Handler1, [], name: Handler1)
  end
end

defmodule Handler0 do
  def handle(event) do
    :timer.sleep(1)
    IO.inspect("Handler0, handled #{inspect event}")
    event
  end
end

defmodule Handler1 do
  use GenServer

  def handle(event) do
    GenServer.call(__MODULE__, {:handle, event})
  end

  def handle_call({:handle, event}, _from, st) do
    :timer.sleep(1)
    IO.inspect("Handler1, handled #{inspect event}")
    {:reply, event, st}
  end
end
