# Liquid Haskell experiences collection repo

This repo contains a LiquidHaskell project incorporating @ranjitjhala's
homeworks from his CSE230 Wi19 course.

Additionally, there's a script `autocommitter.py` which will watch all the
files in the repo, and commit whenever you change them. The script has two
interesting features:

* It always checks out a branch with your current user's username before
  committing. In this way, many people can share the same repo easily because
  we'll be committing to distinct branches.
* If you include "WTF" in a Haskell comment starting with `--` on a line of its
  own, the autocommitter script will include the text of your comment in the
  commit message and then delete the comment. For example, if you have a
  problem while writing a proof and you make a comment:
  ```haskell
  blah :: { 1 + 1 == 2 }
  blah = ()
  -- why does SMT think one plus one is two, WTF
  ```
  When you save the file, the autocommitter script will include this comment in
  the commit message and delete the comment from the file. It's recommended
  that you configure your editor to auto-reload changed files.

## Sources

CSE230 Wi19 course repos which were merged into this one:

* <https://github.com/ucsd-cse230-wi19/hw1> c6b64d537a7af3874bcd974fc1402dffa1a3000b
* <https://github.com/ucsd-cse230-wi19/hw2> e78e4096168b812303ed037e7306df77c1aba705
* <https://github.com/ucsd-cse230-wi19/hw3> cbe6e00d8b01e73cb1ab5e409dd9ff878576c335
* <https://github.com/ucsd-cse230-wi19/hw4> e97c0df6e48d1563e4c7d9e332f5d6f9f0e14825
* <https://github.com/ucsd-cse230-wi19/hw5> 442676bf2f002bcb4ca589711c24a9539401b32d
* <https://github.com/ucsd-cse230-wi19/hw6> 812b99bde88961b9ba1c06bf64d8bf7e01a54d45
