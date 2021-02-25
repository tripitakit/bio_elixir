defmodule BioElixir.SeqIO do
  @moduledoc """
  false
  """
  alias BioElixir.Seq
  alias BioElixir.SeqIO.{EagerFastaParser, LazyFastaParser}

  @spec read_fasta_file(binary) :: [Seq.t()]
  defdelegate read_fasta_file(path), to: EagerFastaParser

  @spec lazy_read_fasta(binary) :: [Seq.t()]
  defdelegate lazy_read_fasta(path), to: LazyFastaParser
end
