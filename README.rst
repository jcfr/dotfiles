========
dotfiles
========

The organization of this project is based on the great work of `@jessfraz <https://github.com/jessfraz>`_.
See `here <https://github.com/jessfraz/dotfiles>`_ for the original project.

Installation
============

::

  $ make

This will create symlinks from this repo to your home folder.

Customization
=============

Save env vars, etc in a ``.extra`` file, that looks something like
this::

  ###
  ### Git credentials
  ###

  GIT_AUTHOR_NAME="Your Name"
  GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
  git config --global user.name "$GIT_AUTHOR_NAME"
  GIT_AUTHOR_EMAIL="email@you.com"
  GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
  git config --global user.email "$GIT_AUTHOR_EMAIL"
  GH_USER="nickname"
  git config --global github.user "$GH_USER"

Test
====

The tests use `shellcheck <https://github.com/koalaman/shellcheck>`_. You don't
need to install anything. They run in a container.

::
  $ make test

