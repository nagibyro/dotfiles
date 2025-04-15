#!/bin/bash

function my_work {
  jira issue list -a$(jira me) --jql "status NOT IN ('Done', 'Won\'t Do')"
}
