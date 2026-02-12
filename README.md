# dotfiles

My personal dotfiles and bootstrap scripts to quickly set up
my preferred shell, tools, and development environment.

## Installation

First, clone this repository:

```bash
git clone https://github.com/linhns/dotfiles.git
```

Then, change into the directory:

```bash
cd dotfiles
```

Finally, create the symlinks using [GNU Stow](https://www.gnu.org/software/stow/):

```bash
stow . --no-folding
```

## Usage

Feel free to fork, copy, and adapt this repository to fit your own workflow
as this setup is meant to be a starting point, customizations should be handled
carefully to avoid leaking personal data.

It is suggested to visualize what Stow will create by running:

```bash
stow . --no-folding --simulate
```

## License

[MIT](https://choosealicense.com/licenses/mit/)
