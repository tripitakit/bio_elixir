defmodule BioElixir.Seq do
  @moduledoc """
    Seq represents DNA sequences as structures
    composed of display_id and seq strings.
  """

  alias BioElixir.Seq

  defstruct [:display_id, :seq]

  @typedoc """
  Type that represents Seq struct with :display_id and :seq as strings.
  """
  @type t :: %Seq{display_id: String.t(), seq: String.t()}

  @doc """
    new/2
    Create a new Seq structure, given display_id and sequence.
  """
  @spec new(display_id :: String.t(), seq :: String.t()) :: {:ok, Seq.t()}
  def new(display_id, seq) do
    new_seq = %Seq{
      display_id: display_id,
      seq: seq
    }

    {:ok, new_seq}
  end

  @doc """
    reverse_complement/1
    Reverse and complement a Seq's nucleotide sequence.
  """
  @spec reverse_complement(sequence :: Seq.t()) :: {:ok, Seq.t()}
  def reverse_complement(%Seq{} = sequence) do
    new_seq = %Seq{
      display_id: sequence.display_id,
      seq: do_reverse_complement(sequence.seq)
    }

    {:ok, new_seq}
  end

  def reverse_complement(other) do
    {:error, "Expecting a %Seq{}, but received #{inspect(other)}."}
  end

  @spec do_reverse_complement(nt_seq :: String.t()) :: String.t()
  defp do_reverse_complement(nt_seq) when is_binary(nt_seq) do
    nt_seq
    |> String.upcase()
    |> String.split("", trim: true)
    |> Enum.reduce([], fn nt, acc -> [complement(nt) | acc] end)
    |> Enum.join("")
  end

  defp complement("A"), do: "T"
  defp complement("T"), do: "A"
  defp complement("G"), do: "C"
  defp complement("C"), do: "G"
  defp complement("N"), do: "N"

  defp complement(nt) do
    raise RuntimeError,
      message: "Invalid DNA nucleotide code: #{nt}"
  end
end
