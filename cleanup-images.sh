#!/bin/bash
# Used to remove orphaned docker images

# Remove all untagged docker images.
docker rmi $(docker images | grep "^<none>" | awk '{print $3}')
