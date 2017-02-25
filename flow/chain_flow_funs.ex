defmodule EventReceiver do
  def handle(event) do
    Handler0.handle(event)
  end
end

defmodule Handler0 do
  def handle(event) do
    :timer.sleep(1)
    IO.inspect("Handler0, handled #{inspect event}")
    Handler1.handle(event)
  end
end

defmodule Handler1 do
  def handle(event) do
    :timer.sleep(1)
    IO.inspect("Handler1, handled #{inspect event}")
  end
end
