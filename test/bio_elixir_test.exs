defmodule BioElixirTest do
  use ExUnit.Case

  alias BioElixir.Seq

  test "create new Seq from string arguments" do
    seq = Seq.new("AN001", "ATCGN")
    assert seq == %Seq{display_id: "AN001", seq: "ATCGN"}
  end

  test "reverse complement a Seq" do
    seq = Seq.new("AN002", "ATCGN")
    assert Seq.reverse_complement(seq) == %Seq{display_id: "AN002", seq: "NCGAT"}
  end
end
