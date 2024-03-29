Jason's dotfiles
===============

Idea and text for this README mostly ganked from [njonsson/dotfiles](https://github.com/njonsson/dotfiles).

This repository contains my OS X shell configuration.

First, create a ~/.api-tokens.yml file with contexts like (replace with you actual API keys):

    ---
    gemcutter: 7hasfuke9asdfmnasfhe89
    github: jkasdjf8asdkenfasd9ekkj

Then simply:

1. Clone this repository.
2. `cd` into it.
3. Type `rake --tasks`.

You should see the following, where _~_ is the path to your home directory:

    rake              # Create symbolic links and generate files in ~ without overwriting existing files
    rake setup        # Create symbolic links and generate files in ~ without overwriting existing files
    rake setup:force  # Delete and recreate symbolic links and generated files in ~

When you type `rake`, all the files in the root of this repository† are either
symbolically linked or generated into your home directory, with a dot prepended
to the filename of each link. For example, the _gemrc_ in this repository gets
symbolically linked to _~/.gemrc_ (unless there is already a _.gemrc_ in your
home directory). The _vimrc.local.erb_ in this repository is used to generate
_~/.vimrc.local_ (unless there is already a _.vimrc.local_ in your home
directory).  In addition, all directories are sybolically linked (unless already 
existing).

Leaving off the dots in these files makes them more convenient for me to edit
and manage, and it allows me to ignore dotfiles that pertain to this repository
rather than to my home directory.

----------------------------------------------------------------

† Note: _Rakefile_, _*.markdown_ and _*-generated_ are not treated as dotfiles.