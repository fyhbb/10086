# Elixir混乱代码
# 功能：简单的Web服务器和数据处理
# 作者：某个不想透露姓名的程序员

defmodule ChaosServer do
  # 全局状态
  use GenServer
  
  # 客户端API
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end
  
  def process_data(server, data) do
    GenServer.call(server, {:process, data})
  end
  
  def get_stats(server) do
    GenServer.call(server, :stats)
  end
  
  # 服务端回调
  def init(:ok) do
    {:ok, %{data: [], counter: 0, level: 1}}
  end
  
  def handle_call({:process, data}, _from, state) do
    # 混乱的处理逻辑
    processed = data
    |> Enum.map(fn x -> x * state.counter + 42 end)
    |> Enum.filter(fn x -> x > 0 end)
    |> Enum.sort(:desc)
    
    new_counter = state.counter + length(data)
    new_level = if new_counter > 100, do: state.level + 1, else: state.level
    
    new_state = %{state | 
      data: state.data ++ processed,
      counter: new_counter,
      level: new_level
    }
    
    {:reply, processed, new_state}
  end
  
  def handle_call(:stats, _from, state) do
    stats = %{
      total_processed: state.counter,
      data_count: length(state.data),
      level: state.level,
      average: calculate_average(state.data)
    }
    {:reply, stats, state}
  end
  
  # 私有函数
  defp calculate_average([]), do: 0
  defp calculate_average(list) do
    Enum.sum(list) / length(list)
  end
end

# 数据处理模块
defmodule ChaosDataProcessor do
  @moduledoc """
  这是一个混乱的数据处理模块
  """
  
  # 处理字符串
  def process_string(str) do
    str
    |> String.downcase()
    |> String.split(" ")
    |> Enum.map(fn word -> 
      word 
      |> String.reverse()
      |> String.upcase()
    end)
    |> Enum.join("_")
  end
  
  # 处理数字
  def process_number(num) when is_number(num) do
    cond do
      num > 100 -> num * 2 - 42
      num > 50 -> num + 100
      num > 0 -> num * num
      true -> 0
    end
  end
  
  # 生成随机数据
  def generate_random_data(count) do
    Enum.map(1..count, fn _ -> 
      :rand.uniform(1000)
    end)
  end
  
  # 混乱的排序算法
  def chaos_sort(list) do
    list
    |> Enum.with_index()
    |> Enum.sort_by(fn {val, idx} -> val + idx end)
    |> Enum.map(fn {val, _} -> val end)
  end
end

# 主程序
defmodule ChaosMain do
  def run do
    IO.puts("=== Elixir混沌程序开始 ===")
    
    # 启动服务器
    {:ok, server} = ChaosServer.start_link()
    
    # 生成测试数据
    test_data = ChaosDataProcessor.generate_random_data(20)
    IO.puts("生成的数据: #{inspect(test_data)}")
    
    # 处理数据
    result = ChaosServer.process_data(server, test_data)
    IO.puts("处理结果: #{inspect(result)}")
    
    # 字符串处理
    test_strings = ["Hello World", "Chaos Programming", "Elixir Magic"]
    processed_strings = Enum.map(test_strings, &ChaosDataProcessor.process_string/1)
    IO.puts("处理后的字符串: #{inspect(processed_strings)}")
    
    # 数字处理
    test_numbers = [150, 75, 25, -10]
    processed_numbers = Enum.map(test_numbers, &ChaosDataProcessor.process_number/1)
    IO.puts("处理后的数字: #{inspect(processed_numbers)}")
    
    # 获取统计信息
    stats = ChaosServer.get_stats(server)
    IO.puts("统计信息: #{inspect(stats)}")
    
    # 混乱排序
    unsorted = [5, 2, 8, 1, 9, 3]
    sorted = ChaosDataProcessor.chaos_sort(unsorted)
    IO.puts("混乱排序: #{inspect(sorted)}")
    
    IO.puts("=== 程序执行完成 ===")
  end
end

# 运行主程序
ChaosMain.run()