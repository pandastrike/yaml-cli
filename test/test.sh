#!/usr/bin/env bash

echo -n 'property accessor...'
result=$(bin/yaml get test/test.yaml 'foo.bar')
if [ "${result}" -eq 7 ]
then
  echo pass
else
  echo failure: 'foo.bar'
fi

echo -n 'array accessor...'
result=$(bin/yaml get test/test.yaml 'foo.baz[1]')
if [ "${result}" = 'hello world' ]
then
  echo pass
else
  echo failure: 'foo.baz[1]'
fi

echo -n 'property mutator...'
bin/yaml set test/test.yaml 'foo.bar' '13' > test/test-2.yaml
result=$(bin/yaml get test/test-2.yaml 'foo.bar')
if [ "${result}" -eq 13 ]
then
  echo pass
else
  echo failure: 'foo.baz[1]'
fi

echo -n 'array mutator...'
bin/yaml set test/test.yaml 'foo.baz[1]' 'goodbye' > test/test-2.yaml
result=$(bin/yaml get test/test-2.yaml 'foo.baz[1]')
if [ "${result}" = 'goodbye' ]
then
  echo pass
else
  echo failure: 'foo.baz[1]'
fi

echo -n 'template instantiation...'
result=$(bin/yaml template test/test.yaml test/template.txt)
if [ "${result}" = $'I\'d like to say hello world' ]
then
  echo pass
else
  echo failure: template instantiation
fi
