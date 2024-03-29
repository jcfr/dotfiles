========
dotfiles
========

.. image:: https://github.com/jcfr/dotfiles/actions/workflows/shellcheck.yml/badge.svg
  :target: https://github.com/jcfr/dotfiles/actions/workflows/shellcheck.yml
  :alt: GitHub Actions

The organization of this project is based on the great work of `@jessfraz <https://github.com/jessfraz>`_.
See `here <https://github.com/jessfraz/dotfiles>`_ for the original project.

Installation
============

::

  $ git clone --recurse-submodules git@github.com:jcfr/dotfiles
  $ cd dotfiles
  $ make

This will create symlinks from this repo to your home folder.

::

  $ make aptfile desktop

This will install packages (e.g powerline, python, virtualenwrapper) and setup desktop launchers


Customization
=============

Save env vars, etc in a ``.extra`` file, that looks something like
this::

  ###
  ### Customization
  ###
  PROMPT_USE_POWERLINE=false # Disable use of powerline (enabled by default)

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


Troubleshoot
============

* Powerline git status does not show up. See `Reloading powerline after update <https://powerline.readthedocs.io/en/master/tips-and-tricks.html#reloading-powerline-after-update>`_

