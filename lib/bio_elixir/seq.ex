defmodule BioElixir.Seq do
  @moduledoc """
    Seq represents DNA sequences as structures
    composed of display_id and seq strings.

  """

  defstruct [:display_id, :seq]
  alias BioElixir.Seq

  @doc """
    new/2
    Create a new sequence structure, given display_id and sequence.
  """
  @spec new(display_id :: String.t(), seq :: String.t()) :: %Seq{}
  def new(display_id, seq) do
    %Seq{
      display_id: display_id,
      seq: seq
    }
  end

  @doc """
    reverse_complement/1
    Reverse and complement a nucleotide sequence.
  """
  @spec reverse_complement(sequence :: %Seq{}) :: %Seq{}
  def reverse_complement(%Seq{} = sequence) do
    %Seq{
      display_id: sequence.display_id,
      seq: _reverse_complement(sequence.seq)
    }
  end

  @spec _reverse_complement(nt_seq :: String.t()) :: String.t()
  defp _reverse_complement(nt_seq) when is_binary(nt_seq) do
    nt_seq
    |> String.upcase()
    |> String.split("", trim: true)
    |> Enum.reduce([], fn nt, acc -> [_complement(nt) | acc] end)
    |> Enum.join("")
  end

  defp _complement("A"), do: "T"
  defp _complement("T"), do: "A"
  defp _complement("G"), do: "C"
  defp _complement("C"), do: "G"
  defp _complement("N"), do: "N"

  defp _complement(nt) do
    raise RuntimeError,
      message: "Invalid DNA nucleotide code: #{nt}"
  end
end
