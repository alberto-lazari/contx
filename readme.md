# Contx

_A flexible virtual environment manager for your shell_

`contx` is a simple CLI tool that provides virtual environments (contexts) for interactive shells. \
It can be viewed as a very simple virtual layer built on top of the default shell experience,
meant to enhance and simplify its scripting capabilities. \
It is inspired by tools like direnv,
that provide a mechanism to source custom scripts based on the current directory.


## Project-based Functions

The main use-case is defining custom shell functions and behaviors that can be automatically activated for specific contexts,
like custom aliases or functions that only make sense for a very specific set of projects. \
By defining them in the scope of a context you avoid cluttering your system environment,
also allowing context-based namespaces:
you can define multiple generic `build` functions,
that hide some complexity of building a specific project,
without worrying of clashing with other `build` function defined elsewhere.

## Automation

`contx` can also be used to automate common initialization tasks,
like navigating to a project directory,
opening a text editor or a related GUI program,
starting build jobs in the background, etc... \
These are all very simple tasks that I just wanted to automate (or simplify),
after having manually done them countless times.

## How Does It Work?

### Subshell Instance
It simply spawns a shell instance, running a custom init script on top of what you already have. \
The init scripts are essentially what defines your context,
you can run almost anything you want inside of them. \
They can be placed in a centralized filesystem structure or in relevant directories themselves.

By living inside a subshell, the environment can be discarded by simply exiting the shell. \
With this mechanism you can easily enter and exit environments without leaving side effects on you current shell.

### Unnamed/Named Contexts
By creating them in a `.contx/` directory they define an unnamed context,
that can be run by specifying the directory: `contx /path/to/dir`

You can also define named contexts, that can be invoked anywhere, like with `contx MyProj`.
You can use it to define contexts which are not necessarily tied to a specific directory,
but just provides functions or common environments.
I personally use them to define contexts that I want to version in a repository,
so that I don't include `.contx/` dirs in projects I share with others.

### Examples

You can look at my [dotfiles repo](https://github.com/alberto-lazari/.dotfiles/tree/main/contx/contexts) for some contexts I'm using.

## Why Not Using Alternatives?

I'm probably not aware of all possible alternatives out there,
but I had reasons not to use the most popular ones:
- direnv, the main inspiration: it uses an implicit approach, where you navigate to a directory and it loads all relevant scripts. \
  I wanted a cleaner, declarative approach, where you explicitly tell which environment you want to use and when.
  I'm not a huge fan of the allow security system in general too,
  it contributes to make the system deviate from the standard shell experience.
- tmux: cool, but I never used it.
  It seems like wanting to re-create window management in the terminal,
  just like emacs tries to replace your OS.
  It feels cleaner to just use my WM and spawn multiple terminal windows.
  I also can't stand the fact that I would need to invent another layer of keyboard shortcuts that would not collide with vim and my WM.
- venv/rvm/nvm/...: those are language-specific systems,
  mostly related to package management.
  I wanted a scriptable, general-purpose environment manager.
- just/task/make/...: those are cool,
  but meant for tasks and I want to automate every aspect of my shell interactions,
  like opening a project I'm working on, along with relevant external tools.
- nix-shell: looks very cool, but I never found time to look into it.
  It also looks like a configuration manager rather than a system that would allow me to run simple scripts.
  It's probably too powerful for such trivial purposes.
- Containers (docker/podman/...): absolutely overkill.
  I'm not interested in isolation or reproducibility.
  It would also bring a huge overhead with it.
