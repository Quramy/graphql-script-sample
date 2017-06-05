#!/bin/bash

function getPR() {
  BRANCH_NAME=$(git branch | grep -E "^\*" | cut -f 2 -d " ")
  echo "branch: $BRANCH_NAME" >&2
  data=$(curl -H "Authorization: token $GITHUB_TOKEN" -s -d @- https://api.github.com/graphql << GQL
{ "query": "
  query {
    repository(owner:\"Quramy\", name: \"graphql-script-sample\") {
      ref(qualifiedName: \"$WERCKER_GIT_BRANCH\") {
        name,
        associatedPullRequests(first: 1) {
          totalCount,
          edges {
            node {
              id
              comments(first: 100) {
                edges {
                  node {
                    bodyText
                  }
                } 
              }
            }
          }
        }
      }
    }
  }
" }
GQL
  )
  echo $data
}

getPR
