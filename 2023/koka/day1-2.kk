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
      ).map(fn (log)
        log.println
        log
      ).filter-map(fn (s) parse-int(s)).sum().println

fun get-numbers(s : string) : console list<string>
  var numbers-found := []
  var mounting := ""

  s.foreach(fn (c)
    if is-digit(c) then
      numbers-found := numbers-found.append([c.string])
    else
      val word = mounting ++ c.string
      match numbers.find(fn ((n, _)) n == word)
        Just((_, n)) ->
          numbers-found := numbers-found.append([n.show])
          mounting := ""
        Nothing ->
          match numbers.find(fn ((n, _)) n.starts-with(word).is-just)
            Just (_) ->
              mounting := word
            Nothing ->
              mounting := c.string

      ()
  )

  numbers-found