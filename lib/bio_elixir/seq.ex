defmodule BioElixir.Seq do
  @moduledoc """
    Seq represents DNA sequences as structures
    composed of display_id and seq strings.
  """

  alias BioElixir.{Alphabet, Seq}

  defstruct [:display_id, :seq]

  @typedoc """
  Type that represents Seq struct with :display_id and :seq as strings.
  """
  @type t :: %Seq{display_id: binary(), seq: binary()}

  @doc """
    new/2
    Create a new Seq structure, given display_id and sequence.
  """
  @spec new(display_id :: binary(), seq :: binary()) :: {:ok, Seq.t()}
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
  @spec reverse_complement(sequence :: Seq.t()) :: {:ok, Seq.t()} | {:error, binary()}
  def reverse_complement(%Seq{} = sequence) do
    with {:ok, reverse_complement_seq} <- do_reverse_complement(sequence.seq) do
      new_seq = %Seq{
        display_id: sequence.display_id,
        seq: reverse_complement_seq
      }

      {:ok, new_seq}
    end
  end

  @spec reverse_complement(sequence :: binary()) :: {:ok, binary()} | {:error, binary()}
  def reverse_complement(sequence) when is_binary(sequence) do
    do_reverse_complement(sequence)
  end

  def reverse_complement(other) do
    {:error, "Expecting a %Seq{} or a String, but received #{inspect(other)}."}
  end

  @spec do_reverse_complement(nt_seq :: binary()) :: {:error, binary()} | {:ok, binary()}
  defp do_reverse_complement(nt_seq) when is_binary(nt_seq) do
    complement_seq =
      nt_seq
      |> String.upcase()
      |> String.split("", trim: true)
      |> Enum.map(&Alphabet.complement(&1))

    case Enum.any?(complement_seq, &is_nil(&1)) do
      false ->
        reverse_complement_seq =
          complement_seq
          |> Enum.reverse()
          |> Enum.join("")

        {:ok, reverse_complement_seq}

      true ->
        {:error, "Unknown nucleotide code in DNA sequence."}
    end
  end
end
