defmodule FreelanceReportsGenerator.Parser do
  def parse_file(file_name) do
    "reports/#{file_name}"
    |> File.stream!()
    |> Enum.map(fn line -> parse_line(line) end)
  end

  def parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> List.update_at(1, fn hours_worked -> String.to_integer(hours_worked) end)
  end
end
