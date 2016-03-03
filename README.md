# yaml-cli

A simple CLI for working with YAML files.

## Examples

Given the following `test.yml` file:

```yaml
foo:
  bar: 7
  baz:
    - 17
    - "hello world"
```

You can get properties:

```bash
$ yaml get test.yaml foo.bar
7
```

or array accessors:

```bash
$ yaml test.yaml foo.baz.1
hello world
```

You can set values, too.

```bash
$ yaml set test.yaml foo.baz.1 goodbye
foo:
  bar: 7
  baz:
    - 17
    - "goodbye"
```

You can instantiate template files, too. Given the following template:

```
I would like to say {{foo.baz.1}}
```

you can instantiate it like this:

```bash
$ yaml t test.yaml test.template
I would like to say hello world
```

You can get more help by just typing `yaml`.

```bash
$ yaml
Usage: yaml <command> [<args>]

Some useful yaml commands are:
   commands  List all yaml commands
   get       Get a value from a YAML file
   set       Set a value in a YAML file
   template  Instantiate a template file with a YAML file.

See 'yaml help <command>' for information on a specific command.
```

## Installation

```bash
$ npm install -g yaml-cli
```

## Shell Completion

You can set up shell completion like this:

```bash
$ eval $(yaml env -)
```

## Limitations

See the [issues list](https://github.com/pandastrike/yaml-cli/issues)—and please open your own or `+1` your favorites.
