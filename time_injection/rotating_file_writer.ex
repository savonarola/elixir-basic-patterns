defmodule RotatingFileWriter do

  use GenServer

  @default_check_interval 1000

  def init([... ,check_interval , ...]) do
    ...
    timer_ref = :erlang.start_timer(check_interval, self, :tick)
    st = %{
      ...
      timer_ref: timer_ref
      ...
    }
    {:ok, st}
  end

  def check_file_name_actuality(pid, time \\ now) do
    GenServer.cast(pid, {:check_file_name_actuality, time})
  end

  defp now do
    Timex.now
  end

  def handle_cast({:check_file_name_actuality, time}, st) do
    new_st = maybe_reopen_file(time, st)
    {:noreply, new_st}
  end

  def handle_info({:timeout, _timer_ref, :tick}, st) do
    new_timer_ref = :erlang.start_timer(st.check_interval, self, :check_file_name_actuality)
    :erlang.cancel_timer(st.timer_ref)
    check_file_name_actuality(self)
    {:noreply, %{st | timer_ref: new_timer_ref}}
  end

  ...

end
