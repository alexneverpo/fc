
#!/usr/bin/env bash

GIT_DIR=$(git rev-parse --git-dir)

echo "Installing hooks..."
# this command creates symlink to our pre-commit script
ln -s ../../scripts/pre_commit.bash $GIT_DIR/hooks/pre-commit
# ln -s ../../scripts/pre_push.bash $GIT_DIR/hooks/pre-push
echo "Done!"
