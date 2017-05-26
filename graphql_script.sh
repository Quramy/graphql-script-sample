#!/bin/bash

data=$(curl -H "Authorization: token $GITHUB_TOKEN" -s -d @- https://api.github.com/graphql << GQL
{ "query": "
  query {
    viewer {
      login
    }
  }
" }
GQL
)

echo $data | jq -r .data.viewer.login
