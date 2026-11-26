#!/usr/bin/env bash
# Gives every repository that publishes packages the VPM_DISPATCH_TOKEN secret,
# so that its release job can ask this listing to rebuild.
#
#   ./issue-dispatch-token.sh              # asks for the token, without echoing it
#   ./issue-dispatch-token.sh < token.txt  # or reads it from a file
#
# The token is a fine-grained personal access token with "Contents: read and
# write" on CassidyPrather/vpm and nothing else (GitHub > Settings > Developer
# settings > Fine-grained tokens). That one permission is what lets it send a
# repository_dispatch here. It goes to the repositories in source.json and to
# the template new package repositories are made from. Needs the gh CLI,
# signed in as someone who can set secrets on them.
#
# Run it again whenever the token is replaced, or a repository is added.
set -euo pipefail
cd "$(dirname "$0")"

TEMPLATE="CassidyPrather/vpm-package-template"

if [ -t 0 ]; then
    read -rsp "VPM_DISPATCH_TOKEN: " token
    echo
else
    read -r token
fi
if [ -z "$token" ]; then
    echo "no token given" >&2
    exit 1
fi

repos=$(python3 -c 'import json; print("\n".join(json.load(open("source.json"))["githubRepos"]))' 2>/dev/null \
    || python -c 'import json; print("\n".join(json.load(open("source.json"))["githubRepos"]))')

failed=0
for repo in $repos "$TEMPLATE"; do
    if printf '%s' "$token" | gh secret set VPM_DISPATCH_TOKEN --repo "$repo"; then
        echo "set on $repo"
    else
        echo "FAILED on $repo" >&2
        failed=1
    fi
done
exit $failed
