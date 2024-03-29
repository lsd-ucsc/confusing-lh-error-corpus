# Liquid Haskell confusing error corpus repo

This repo contains a Liquid Haskell project incorporating @ranjitjhala's
homeworks from his CSE230 Wi19 course. The goal of this repo is to collect a
corpus of Liquid Haskell programs that generate type errors which users find
confusing. It works by recording the writes made to files and committing them
automatically. Our goal is to use this corpus to improve the Liquid Haskell
proof-engineering experience.

## Setup: Liquid Haskell & Autocomitter

* **Liquid Haskell**: Choose `stack`, `nix`, or `cabal`.
  * `stack build --file-watch` should just work.
  * `nix build` should just work. You can also do incremental compilation in a
    `nix develop` development by running `make entr-build` or `make ghcid`. If
    you want to use the older `nix-build`/`nix-shell` tools, there's
    [flake-compat](https://github.com/edolstra/flake-compat) (or create an
    issue on the repo it'll get added).
  * `cabal` doesn't have a project file in this directory but there's examples
    which can be adapted at
    [lh-plugin-demo](https://github.com/ucsd-progsys/lh-plugin-demo) (or create
    an issue on the repo it'll get added).

* **Autocommitter**: Install script dependencies.
  * [entr](https://github.com/eradman/entr#event-notify-test-runner) to watch
    for file changes. Most linux distros distribute **entr** by now, but not
    all. It is also on homebrew, for macs.
  * python3, find, grep, sed, and git

## Workflow: Log your Liquid Haskell experience

1. `git clone ...` this repo to your computer.
1. Run `autocommitter.py`. It will check out a branch and commit every write
   you make to files in the repo.
1. While the autocommitter continues to run, edit files in the repo using your
   normal Liquid Haskell compiler and editor flow.
   1. Open up `lib/Hw1.hs` to start. The only files you'll edit in this repo
      are the `lib/Hw*.hs` files.
   1. Remove the `{-@ IGNORE ... @-}` LH pragmas at the top of the file as you
      work on each of the binders listed there. You could also remove them all
      at once, but then it's harder to tell whether your in-progress work is
      copacetic.
1. When you're all done, stop the autocommitter and push your branch.

## Autocomitter details

The `autocommitter.py` script will watch all the files in the repo, and
commit to a branch whenever you make changes.
It is recommended that you run the autocommitter script in a terminal, and then
edit the files in your normal editor with your normal compilation tools or IDE
tools.
In this way, you can track your own edit history of LH proofs.

The autocommitter script has two interesting features:

* **Commits to a branch:** The script always checks out a branch with your
  current user's username before committing. In this way, many people can share
  the same repo easily without mistakenly committing to each other's branches.
* **Easily mark interesting commits:** If you include "WTF" in a Haskell
  comment starting with `--` on a line of its own, the autocommitter script
  will include the text of your comment in the commit message and then delete
  the comment. In this way you can easily mark the commits for later
  examination.

  For example, while writing a proof if you make a comment like the following:
  ```haskell
  blah :: { 1 + 1 == 2 }
  blah = ()
  -- why does SMT think one plus one is two, WTF
  ```
  Then, when you save the file, the autocommitter script will include this
  comment in the commit message and delete the comment from the file. It's
  recommended that you configure your editor to auto-reload changed files.


## Sources

CSE230 Wi19 course repos which were merged into this one:

* <https://github.com/ucsd-cse230-wi19/hw1> c6b64d537a7af3874bcd974fc1402dffa1a3000b
* <https://github.com/ucsd-cse230-wi19/hw2> e78e4096168b812303ed037e7306df77c1aba705
* <https://github.com/ucsd-cse230-wi19/hw3> cbe6e00d8b01e73cb1ab5e409dd9ff878576c335
* <https://github.com/ucsd-cse230-wi19/hw4> e97c0df6e48d1563e4c7d9e332f5d6f9f0e14825
* <https://github.com/ucsd-cse230-wi19/hw5> 442676bf2f002bcb4ca589711c24a9539401b32d
* <https://github.com/ucsd-cse230-wi19/hw6> 812b99bde88961b9ba1c06bf64d8bf7e01a54d45
