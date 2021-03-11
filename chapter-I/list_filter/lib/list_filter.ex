defmodule ListFilter do
  require Integer

  def call(list), do: filter(list)

  defp filter(list) do
    list
    |> Enum.filter(fn x ->
      case Integer.parse(x) do
        {integer, _decimal} ->
          if(Integer.is_odd(integer) == true) do
            true
          else
            false
          end

        :error ->
          false
      end
    end)
    |> Enum.count()
  end
end
