import std/core/types
import std/os/file
import std/os/path

val numbers = [
  ("one", 1),
  ("two", 2),
  ("three", 3),
  ("four", 4),
  ("five", 5),
  ("six", 6),
  ("seven", 7),
  ("eight", 8),
  ("nine", 9)
]

fun main()
  match try(fn () "./input.txt".path.read-text-file)
    Error(e) -> e.show.println
    Ok(i) ->
      i.lines.map(get-numbers).map(fn (l)
        l.head.string ++ l.last.string
      ).filter-map(fn (s) parse-int(s)).sum().println

fun get-numbers(s : string) : console list<string>
  var found := []
  var word := ""

  s.list.foreach-indexed(fn (i, c)
    if is-digit(c) then
      found := found ++ [c.string]
    else
      s.slice.advance(i).foreach-while(fn (c2)
        val nw = word ++ c2.string

        match numbers.find(fn ((n, _)) n == nw)
          Just((_, n)) ->
            found := found ++ [n.show]
            return Just(())

          Nothing ->
            match numbers.find(fn ((n, _)) n.starts-with(nw).is-just)
              Just (_) ->
                word := nw
              Nothing ->
                return Just(())

        Nothing
      )

      ()
  )

  found