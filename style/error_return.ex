defmodule ErrorReturn do

  def sqrt_good(x) when is_float(x) and x >= 0 do
    {:ok, :math.sqrt(x)}
  end
  def sqrt_good(x) when is_float(x) do
    :error
  end

  def sqrt_bad(x) when is_float(x) and x >= 0 do
    :math.sqrt(x)
  end
  def sqrt_bad(x) when is_float(x) do
    :error
  end

  @doc """
  Log of sqrt of the last number in a string

  ## Examples

      iex> log_sqrt_last("a b 10000")
      2.0

  """

  def log_sqrt_last(str) do
    with words <- String.split(str, ~r/\s+/),
      last_word <- List.last(words),
      {last_number, ""} <- Float.parse(last_word),
      {:ok, sqrt} <- sqrt_good(last_number),
      # sqrt when sqrt != :error <- sqrt_bad(last_number), # :((
      log <- :math.log10(sqrt)
    do
      {:ok, log}
    end
  end

end
