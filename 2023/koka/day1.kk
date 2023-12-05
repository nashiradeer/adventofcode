import std/os/file
import std/os/path

fun main()
  match try(fn () "./day1-input.txt".path.read-text-file)
    Error(e) -> e.show.println
    Ok(s) -> match s.lines.head
      Just(a) -> a.println
      Nothing -> println("Nothing :/")
