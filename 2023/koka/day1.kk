import std/os/file
import std/os/path

fun main()
  match try(fn () "./input.txt".path.read-text-file)
    Error(e) -> e.show.println
    Ok(i) -> i.lines.map(fn (s) s.list.filter(is-digit).string).map(fn (s)
      val l = s.list
      l.head.map(string).string ++ l.last.map(string).string
    ).filter-map(fn (s) parse-int(s)).sum().println
