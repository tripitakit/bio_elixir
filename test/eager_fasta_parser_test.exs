defmodule EagerFastaParserTest do
  use ExUnit.Case

  alias BioElixir.{Alphabet, Seq, SeqIO}

  test "create new DNA Seq from string arguments" do
    {:ok, seq} = Seq.new("AN001", "ATCGN")
    assert seq == %Seq{display_id: "AN001", seq: "ATCGN"}
  end

  test "reverse complement a DNA Seq" do
    {:ok, seq} = Seq.new("AN002", "ATCGN")
    assert Seq.reverse_complement(seq) == {:ok, %Seq{display_id: "AN002", seq: "NCGAT"}}
  end

  test "complement valid DNA nt-code" do
    assert Alphabet.complement("A") == "T"
  end

  test "complement invalid DNA nt-code" do
    assert Alphabet.complement("J") == nil
  end

  test "parse a fasta multisequence file" do
    input = "test/two-sequences.fasta"

    assert ([seq1, seq2] = SeqIO.read_fasta_file(input)) == [seq1, seq2]

    assert seq1 == %Seq{display_id: "Seq1", seq: "AAATTTCCCGGGGGGCCCTTTAAA"}
    assert seq2 == %Seq{display_id: "Seq2", seq: "GGGCCCTTTAAAAAATTTCCCGGG"}
  end
end
