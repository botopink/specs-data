#!/usr/bin/env bash
# unread.sh [machine-1|machine-2|machine-3|maintainer] — the messages addressed to that side whose `read:` is still
# `[ ]` (for a message to `all`, the side's own check), oldest first. With no argument, every message with an
# unticked check. Exit 1 while something is unread, so a session can gate on it.
set -euo pipefail
cd "$(dirname "$0")/.."
side="${1:-}"
case "$side" in
    ""|machine-1|machine-2|machine-3|maintainer) ;;
    *) echo "unread: side must be machine-1, machine-2, machine-3 or maintainer" >&2; exit 2 ;;
esac
found=0
for f in $(ls machine-*/????????-????-*.md all/????????-????-*.md 2>/dev/null | sort -t/ -k2); do
    to="$(sed -n 's/^to: *\([a-z0-9-]*\).*/\1/p' "$f" | head -1)"
    read_line="$(sed -n 's/^read: *//p' "$f" | head -1 | sed 's/ *#.*$//')"
    from="$(sed -n 's/^from: *\([a-z0-9-]*\).*/\1/p' "$f" | head -1)"
    subject="$(sed -n 's/^subject: *//p' "$f" | head -1)"
    unread=0
    if [ "$to" = all ]; then
        if [ -z "$side" ]; then
            printf '%s' "$read_line" | grep -q '\[ \]' && unread=1
        elif [ "$side" != maintainer ]; then
            n="${side#machine-}"
            check="$(printf '%s' "$read_line" | grep -oE '\[[ x]\]' | sed -n "${n}p")"
            [ "$check" = "[ ]" ] && unread=1
        fi
    else
        if [ -z "$side" ] || [ "$to" = "$side" ]; then
            printf '%s' "$read_line" | grep -q '\[ \]' && unread=1
        fi
    fi
    [ "$unread" -eq 1 ] || continue
    [ "$found" -eq 0 ] && echo "unread messages${side:+ for $side}:"
    found=1
    echo "  $f — from $from: $subject"
done
[ "$found" -eq 0 ] && echo "nothing unread${side:+ for $side}"
[ "$found" -eq 0 ]
