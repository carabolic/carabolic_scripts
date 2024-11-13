#!/usr/bin/env bash

# if [[ $# -eq 1 ]]; then
#     selected=$1
# else
#     selected=$(find ~/work/builds ~/projects ~/ ~/work ~/personal ~/personal/yt -mindepth 1 -maxdepth 1 -type d | fzf)
# fi

# if [[ -z $selected ]]; then
#     exit 0
# fi

# CONFIG
root_dir="~/Development"

available_names=$(cat <<-EOT
development
infrastructure
private
EOT
)

# daily development lyre, koto, lyre-etl, etc.
development_workspace=$(cat <<-EOT
${root_dir}/hellofresh/lyre-etl
${root_dir}/hellofresh/product-analytics-orchestration
EOT
)

# relevant infrastructure: databricks, vault, github automation, etc.
infrastructure_workspace=$(cat <<-EOT
${root_dir}/hellofresh/dsi-pa-infra
${root_dir}/hellofresh/vault-namespace-automation
EOT
)

# private development
private_workspace=$(cat <<-EOT
${root_dir}/private/pyslicker
EOT
)

# LOGIC
selected_name=$(echo "${available_names}" | fzf)
echo "selected name: ${selected_name}"

selected_paths=""       # eventually contains the paths for the individual windows
base_dir="${root_dir}"  # evantually contains the base_dir for the workspace

if [[ $selected_name == "development" ]]; then
    selected_paths=$development_workspace

elif [[ $selected_name == "infrastructre" ]]; then
    selected_paths=$infrastructure_workspace
fi

echo "${selected_name}"
echo "${selected_paths}"

exit 0
tmux_running=$(pgrep tmux)

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    echo "new session ${selected_name} in ${base_dir}"
    tmux new-session -s $selected_name -c "${base_dir}"
fi

# if tmux is not already running create a new session
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

# selected_name=$(basename "$selected" | tr . _)


# if tmux is already running check if session already exists
tmux switch-client -t $selected_name
