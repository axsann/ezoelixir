defmodule Ezoelixir do
  def main(args) do
    show()
  end
  
  def show() do
    HTTPoison.start
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get("http://ask.fm/feed/profile/EzoeRyou.rss")
    {:ok, feed, _} = FeederEx.parse(body)
    Enum.each(feed.entries,
              fn(e) -> 
                IO.puts("#{e.id}")
                "  "<>String.replace(e.title, e.title, IO.ANSI.bright<>e.title<>IO.ANSI.reset)
                |> IO.puts
                "  "<>String.replace(e.summary, ~r/(質問ではない)(。)?|(不)?(自由)/, IO.ANSI.green<>"\\1\\2\\3\\4"<>IO.ANSI.reset)<>"\n"
                |> IO.puts
              end
    )
  end
end
