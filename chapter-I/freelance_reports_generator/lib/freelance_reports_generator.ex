defmodule FreelanceReportsGenerator do
  alias FreelanceReportsGenerator.Parser

  @people [
    "Daniele",
    "Mayk",
    "Giuliano",
    "Cleiton",
    "Jakeliny",
    "Joseph",
    "Diego",
    "Rafael",
    "Vinicius",
    "Danilo"
  ]

  @years [
    "2016",
    "2017",
    "2018",
    "2019",
    "2020"
  ]

  @months %{
    "1" => "janeiro",
    "2" => "fevereiro",
    "3" => "março",
    "4" => "abril",
    "5" => "maio",
    "6" => "junho",
    "7" => "julho",
    "8" => "agosto",
    "9" => "setembro",
    "10" => "outubro",
    "11" => "novembro",
    "12" => "dezembro"
  }
  def build(file_name) do
    file_name
    |> Parser.parse_file()
    |> Enum.reduce(blank_report(), fn line, report ->
      sum_worker_hours(line, report)
    end)
  end

  defp sum_worker_hours(
         [name, hours_worked, _day, month, year],
         %{
           "all_hours" => all_hours,
           "hours_per_month" => hours_per_month,
           "hours_per_year" => hours_per_year
         } = report
       ) do
    all_hours = Map.put(all_hours, name, all_hours[name] + hours_worked)

    hours_per_month = update_entangled_maps(hours_per_month, name, @months[month], hours_worked)

    hours_per_year = update_entangled_maps(hours_per_year, name, year, hours_worked)

    %{
      report
      | "all_hours" => all_hours,
        "hours_per_month" => hours_per_month,
        "hours_per_year" => hours_per_year
    }
  end

  defp update_entangled_maps(map, key_1, key_2, value) do
    Map.put(
      map,
      key_1,
      Map.put(map[key_1], key_2, map[key_1][key_2] + value)
    )
  end

  defp blank_report() do
    all_hours = Enum.into(@people, %{}, fn person -> {person, 0} end)

    hours_per_month =
      Enum.into(@people, %{}, fn person ->
        {person, Enum.into(@months, %{}, fn {_month_number, month} -> {month, 0} end)}
      end)

    hours_per_year =
      Enum.into(@people, %{}, fn person ->
        {person, Enum.into(@years, %{}, fn year -> {year, 0} end)}
      end)

    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end
end
