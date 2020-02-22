defmodule TodoList do
  use GenServer

  def start(todo) do
    {:ok, list} = GenServer.start(__MODULE__, todo)
    list
  end

  def add(list,task) do
    GenServer.cast(list, {:add, task})
  end

  def remove(list,task) do
    GenServer.cast(list, {:remove,task})
  end

  def show(list) do
    GenServer.call(list, :show)
  end

  def handle_cast({:add, task}, todo) do
    {:noreply, task ++ todo }
  end

  def handle_cast({:remove, task}, todo) do
    {:noreply, task -- todo }
  end

  def handle_call(:show,_from,todo) do
    {:reply, todo, todo}
  end
end
