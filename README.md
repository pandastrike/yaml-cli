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

- Property accessors must not contain a period.
- No in-place editing.
- Cannot read from stdin.

These limitations may be addressed in the future. Please open/upvote issues if you'd be interested in a given feature.
