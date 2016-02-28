# yaml-cli

A simple CLI for querying and updating YAML files.

## Examples

Given the following `test.yml` file:

```yaml
foo:
  bar: 7
  baz:
    - 17
    - "hello world"
```

You can query properties:

```bash
$ yaml test.yaml 'foo.bar'
7
```

or array accessors:

```bash
$ yaml test.yaml 'foo.baz[1]'
hello world
```

You can pass a third argument to set a value.

```bash
$ yaml test.yaml 'foo.baz[1]' 'goodbye'
foo:
  bar: 7
  baz:
    - 17
    - "goodbye"
```

## Install

```bash
$ npm install -g yaml-cli
```

## Limitations

- Property accessors must not contain a period.
- Array accessors must be integers.
- No in-place editing.
- Cannot read from stdin.

These limitations may be addressed in the future. Please open/upvote issues if you'd be interested in a given feature.
