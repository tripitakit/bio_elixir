defmodule BioElixir.SeqIO do
  @moduledoc """
  false
  """

  alias BioElixir.SeqIO.FastaParser

  def read_fasta_file(path) do
    path
    |> File.read!()
    |> FastaParser.parse()
  end
end
