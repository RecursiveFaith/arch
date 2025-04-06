#!/usr/bin/env bash

# ~/.config/i3/scripts/i3-tmux-nav.sh
#
# This script handles navigation requests (left, right, up, down)
# and intelligently directs them to either tmux or i3.
#
# It requires 'jq' for parsing i3-msg output.
#
# Usage:
# ./i3-tmux-nav.sh <direction>
# where <direction> is one of: left, right, up, down

# --- Configuration ---
# Add the window classes of your terminal emulators here
TERMINAL_CLASSES=("Alacritty" "kitty" "URxvt" "XTerm" "gnome-terminal") # Add your terminal's class if not listed

# --- Script Logic ---

# Check if a direction argument was provided
if [ -z "$1" ]; then
  echo "Usage: $0 <left|right|up|down>"
  exit 1
fi

DIRECTION=$1

# Function to check if a value is in an array
contains_element() {
  local seeking=$1; shift
  local in=1 # Default to not found (error)
  for element; do
    if [[ "$element" == "$seeking" ]]; then
      in=0 # Found
      break
    fi
  done
  return $in
}

# Get details of the currently focused i3 window using i3-msg and jq
FOCUSED_WINDOW_INFO=$(i3-msg -t get_tree | jq '.. | select(.focused? == true)')
FOCUSED_WINDOW_CLASS=$(echo "$FOCUSED_WINDOW_INFO" | jq -r '.window_properties.class // empty') # Use // empty for robustness

# Check 1: Is the focused window one of our known terminal classes?
IS_TERMINAL=1 # Assume not a terminal initially
if contains_element "$FOCUSED_WINDOW_CLASS" "${TERMINAL_CLASSES[@]}"; then
  IS_TERMINAL=0 # It is a terminal
fi

# Check 2: Is a tmux server running?
# We check this broadly; a more complex check could see if the specific
# terminal PID is associated with a tmux session, but this is simpler.
TMUX_RUNNING=1 # Assume not running
tmux info > /dev/null 2>&1
if [ $? -eq 0 ]; then
  TMUX_RUNNING=0 # Tmux server is running
fi

# Determine if we should try tmux first
TRY_TMUX=1 # Assume no
if [ "$IS_TERMINAL" -eq 0 ] && [ "$TMUX_RUNNING" -eq 0 ]; then
  # Focused window is a terminal AND a tmux server is running
  TRY_TMUX=0
fi

# --- Navigation Execution ---

NAVIGATE_I3=1 # Default to navigating i3

if [ "$TRY_TMUX" -eq 0 ]; then
  # Attempt to navigate within tmux
  case "$DIRECTION" in
    left)
      tmux select-pane -L
      ;;
    right)
      tmux select-pane -R
      ;;
    up)
      tmux select-pane -U
      ;;
    down)
      tmux select-pane -D
      ;;
    *)
      echo "Invalid direction: $DIRECTION"
      exit 1
      ;;
  esac

  # Check if tmux navigation succeeded (exit code 0)
  if [ $? -eq 0 ]; then
    # Tmux handled the navigation, so we don't need i3 to do anything
    NAVIGATE_I3=1 # Set to non-zero (false)
  else
    # Tmux failed (likely at an edge), so we *do* want i3 to navigate
    NAVIGATE_I3=0 # Set to zero (true)
  fi
fi

# If we determined we need to navigate i3 (either not tmux, or tmux was at edge)
if [ "$NAVIGATE_I3" -eq 0 ]; then
  # Use i3-msg to focus in the desired direction
  i3-msg focus "$DIRECTION"
fi

exit 0


