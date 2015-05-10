defmodule Marvel.CLI.Colors do
  
  def red(text) do
    color(:red, text)
  end

  def blue(text) do
    color(:blue, text)
  end

  def cyan(text) do
    color(:cyan, text)
  end

  def green(text) do
    color(:green, text)
  end

  def magenta(text) do
    color(:magenta, text)
  end

  def white(text) do
    color(:white, text)
  end

  def yellow(text) do
    color(:yellow, text)
  end


  defp color(color, text) do
    IO.chardata_to_string(IO.ANSI.format_fragment([color, text], true))
  end
  

end