#!/bin/bash
# Install claude-toolkit: symlink skills, agents, and rules into ~/.claude/
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing claude-toolkit from: $SCRIPT_DIR"

# Skills
if [ -L "$HOME/.claude/skills" ]; then
    rm "$HOME/.claude/skills"
elif [ -d "$HOME/.claude/skills" ]; then
    echo "WARNING: ~/.claude/skills is a real directory, backing up to ~/.claude/skills-backup-$(date +%s)"
    mv "$HOME/.claude/skills" "$HOME/.claude/skills-backup-$(date +%s)"
fi
ln -sfn "$SCRIPT_DIR/skills" "$HOME/.claude/skills"
echo "  skills  → $SCRIPT_DIR/skills ($(ls "$SCRIPT_DIR/skills" | wc -l) skills)"

# Agents
if [ -L "$HOME/.claude/agents" ]; then
    rm "$HOME/.claude/agents"
elif [ -d "$HOME/.claude/agents" ]; then
    echo "WARNING: ~/.claude/agents is a real directory, backing up to ~/.claude/agents-backup-$(date +%s)"
    mv "$HOME/.claude/agents" "$HOME/.claude/agents-backup-$(date +%s)"
fi
ln -sfn "$SCRIPT_DIR/agents" "$HOME/.claude/agents"
echo "  agents  → $SCRIPT_DIR/agents ($(ls "$SCRIPT_DIR/agents" | wc -l) agents)"

# Rules
if [ -L "$HOME/.claude/rules" ]; then
    rm "$HOME/.claude/rules"
elif [ -d "$HOME/.claude/rules" ]; then
    echo "WARNING: ~/.claude/rules is a real directory, backing up to ~/.claude/rules-backup-$(date +%s)"
    mv "$HOME/.claude/rules" "$HOME/.claude/rules-backup-$(date +%s)"
fi
ln -sfn "$SCRIPT_DIR/rules" "$HOME/.claude/rules"
echo "  rules   → $SCRIPT_DIR/rules ($(ls "$SCRIPT_DIR/rules" | wc -l) rules)"

echo ""
echo "Done. Verify with:"
echo "  ls -la ~/.claude/skills ~/.claude/agents ~/.claude/rules"
