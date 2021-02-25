defmodule BioElixir.SeqIO.LazyFastaParser do
  defstruct current_seq: "", sequences: []
  alias BioElixir.SeqIO.LazyFastaParser

  use Agent

  def lazy_read_fasta(path) do
    {:ok, state_pid} = start_link([])

    path
    |> File.stream!()
    |> Enum.map(fn line -> parse(line, state_pid) end)

    store_last_seq(state_pid)
    sequences(state_pid)
  end

  def parse(line, state_pid) do
    if is_fasta_header?(line) do
      new_seq(state_pid, line)
    else
      push_line(state_pid, line)
    end
  end

  @spec start_link(any) :: {:error, any} | {:ok, pid}
  defp start_link(_opts) do
    Agent.start_link(fn ->
      %LazyFastaParser{}
    end)
  end

  defp push_line(state_pid, line) do
    line = line |> String.replace(" ", "") |> String.replace("\n", "")

    Agent.update(state_pid, fn state ->
      %{state | current_seq: state.current_seq <> line}
    end)
  end

  defp new_seq(state_pid, header) do
    Agent.update(state_pid, fn state ->
      if state.current_seq != "" do
        %LazyFastaParser{
          state
          | current_seq: header,
            sequences: [state.current_seq | state.sequences]
        }
      else
        %LazyFastaParser{state | current_seq: header}
      end
    end)
  end

  defp store_last_seq(state_pid) do
    Agent.update(state_pid, fn state ->
      %LazyFastaParser{state | sequences: [state.current_seq | state.sequences]}
    end)
  end

  defp sequences(state_pid) do
    Agent.get(state_pid, fn state ->
      state.sequences
      |> Enum.reverse()
    end)
  end

  defp is_fasta_header?(line), do: String.first(line) == ">"
end
