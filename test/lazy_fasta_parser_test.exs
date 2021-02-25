defmodule LazyFastaparserTest do
  use ExUnit.Case
  alias BioElixir.SeqIO

  test "lazy parse a fasta multisequence file" do
    input = "test/two-sequences.fasta"

    assert ([seq1, seq2] = SeqIO.lazy_read_fasta(input)) == [seq1, seq2]

    assert seq1 == ">Seq1\nAAATTTCCCGGGGGGCCCTTTAAA"
    assert seq2 == ">Seq2\nGGGCCCTTTAAAAAATTTCCCGGG"
  end
end
