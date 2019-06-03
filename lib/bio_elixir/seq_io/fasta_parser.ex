defmodule BioElixir.SeqIO.FastaParser do
  @moduledoc """
  FASTA format input/output tools
  """

  def parse(fasta_string) do
    sequence_separator()
    |> Regex.split(String.trim(fasta_string))
    |> Parallel.filter(&valid_seq?/1)
    |> Parallel.map(&parse_data_string/1)
  end

  defp sequence_separator(), do: ~r/\n+\s*(?=>)/

  defp valid_seq?(data_string) do
    String.contains?(data_string, "\n") && String.starts_with?(data_string, ">")
  end

  defp parse_data_string(data_string) do
    [header, sequence] = Regex.split(~r/\n/, data_string, parts: 2)

    %BioElixir.Seq{display_id: clean_header(header), seq: clean_sequence(sequence)}
  end

  defp clean_header(raw_header) do
    raw_header
    |> String.trim_leading(">")
    |> String.trim()
  end

  defp clean_sequence(raw_sequence) do
    Regex.replace(~r/\s+/, raw_sequence, "")
  end
end
