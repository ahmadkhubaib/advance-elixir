defmodule Parallel do
  def pmap collection, fun do
    collection
    |> Enum.map(&spawn_process(&1, self, fun))
    |> Enum.map(&await/1)
  end

  defp spawn_process element,parent,fun do
    spawn_link fn ->
      send parent, {self, fun.(element)}
    end
  end

  defp await pid do
    receive do
      {^pid, result} ->
        result
    end

  end
end
