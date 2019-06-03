defmodule BioElixir.Alphabet do
  @moduledoc """
  Alphabet for Seq
  """
  @dna_iupac %{
    A: "T",
    C: "G",
    G: "C",
    T: "A",
    U: "A",
    W: "W",
    S: "S",
    M: "K",
    K: "M",
    R: "Y",
    Y: "R",
    B: "V",
    D: "H",
    H: "D",
    V: "B",
    N: "N",
    Z: "Z"
  }

  @spec complement(nt: binary()) :: binary() | nil
  def complement(nt), do: Map.get(@dna_iupac, String.to_atom(nt))
end
