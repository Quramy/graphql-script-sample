#!/bin/bash

function getPR() {
  data=$(curl -H "Authorization: token $GITHUB_TOKEN" -s -d @- https://api.github.com/graphql << GQL
{ "query": "
  query {
    repository(owner:\"$WERCKER_GIT_OWNER\", name: \"$WERCKER_GIT_REPOSITORY\") {
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
