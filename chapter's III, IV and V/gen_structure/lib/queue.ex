defmodule GenStructure.Queue do
  use GenServer

  # Client
  def start_link(state) do
    GenServer.start_link(__MODULE__, state)
  end

  def get_queue(pid) do
    GenServer.call(pid, :get_queue)
  end

  def enqueue(pid, element) do
    GenServer.cast(pid, {:enqueue, element})
  end

  def dequeue(pid) do
    GenServer.call(pid, :dequeue)
  end

  # Server
  @impl true
  def init(queue) when is_list(queue) do
    {:ok, queue}
  end

  @impl true
  def handle_cast({:enqueue, element}, state) do
    new_state = [element | state]
    {:noreply, new_state}
  end

  @impl true
  def handle_call(:dequeue, _from, [_head | _tail] = state) do
    [popped_value | reversed_list] = Enum.reverse(state)
    new_state = Enum.reverse(reversed_list)

    {:reply, popped_value, new_state}
  end

  @impl true
  def handle_call(:dequeue, _from, [] = state) do
    {:reply, nil, state}
  end

  @impl true
  def handle_call(:get_queue, _from, state) do
    {:reply, state, state}
  end
end
