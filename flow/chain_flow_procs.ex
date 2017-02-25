defmodule EventReceiver do
  def handle(event) do
    Handler0.handle(event)
  end

  def start do
    for handler <- [Handler0, Handler1] do
      GenServer.start_link(handler, [], name: handler)
    end
  end
end

defmodule Handler0 do
  use GenServer

  def handle(event) do
    GenServer.cast(__MODULE__, {:handle, event})
  end

  def handle_cast({:handle, event}, st) do
    :timer.sleep(1)
    IO.inspect("Handler0, handled #{inspect event}")
    Handler1.handle(event)
    {:noreply, st}
  end
end

defmodule Handler1 do
  use GenServer

  def handle(event) do
    GenServer.cast(__MODULE__, {:handle, event})
  end

  def handle_cast({:handle, event}, st) do
    :timer.sleep(1)
    IO.inspect("Handler1, handled #{inspect event}")
    {:noreply, st}
  end
end
