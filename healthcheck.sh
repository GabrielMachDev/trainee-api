#!/bin/bash
URL="http://localhost:5000/health"

response=$(curl -s $URL | jq -r '.status')

if [ "$response" == "healthy" ]; then
  echo "API está saudável ✅"
  exit 0
else
  echo "API não respondeu corretamente ❌"
  exit 1
fi