SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  # host          # Hostname section
  git           # Git section (git_branch + git_status)
  node          # Node.js section
  # exec_time     # Execution time
  line_sep      # Line break
  # vi_mode       # Vi-mode indicator
  # jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

antibody bundle denysdovhan/spaceship-prompt
