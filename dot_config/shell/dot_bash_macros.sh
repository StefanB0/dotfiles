### Macros ###
# git
function gcpush () {
	git add .
	git commit -m "$1"
	git push
}

# python
## venv (windows)
function pcvenv () {
	python -m venv .venv
	./.venv/Scripts/activate
}

## utils
function pfilejson () {
	python -m json.tool "$1" > ~/.tmp-json
	cat ~/.tmp-json > "$1"
	rm ~/.tmp-json
}


# env management
denv() {
    local dry_run=0
    local env="local"
    local temp_dir=""
    local env_file=".env.local"  # Default file
    local options_count=0

    # Function to display help
    show_help() {
        echo "Usage: denv [OPTIONS]"
        echo "Manage environment files."
        echo
        echo "Options:"
        echo "  --dry               Dry run: print the contents of the environment file without copying."
        echo "  --dev, -d           Use the development environment file (.env.dev)."
        echo "  --local, -l         Use the local environment file (.env.local)."
        echo "  -c, --config FILE   Use a custom environment file (.env.FILE)."
        echo "  -p, --path PATH     Use a custom path to the environment file (./temp/)."
        echo "  --help, -h          Show this help message and exit."
        echo
        echo "Example:"
        echo "  denv --dev        # Use the development environment file."
        echo "  denv -c staging   # Use the staging.env file."
        echo "  denv --dry         # Dry run with the default local.env file."
    }

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --dry)
                dry_run=1
                shift
                ;;
            --dev|-d)
                env="dev"
                options_count=$((options_count + 1))
                shift
                ;;
            --local|-l)
                env="local"
                options_count=$((options_count + 1))
                shift
                ;;
            --config|-c)
                if [[ -n "$2" ]]; then
                    env="${2}"
                    options_count=$((options_count + 1))
                    shift 2
                else
                    echo "Error: $1 requires a filename argument."
                    return 1
                fi
                ;;
            --path|-p)
                if [[ -n "$2" ]]; then
                    temp_dir="./${2}/"
                    shift 2
                else
                    echo "Error: $1 requires a path argument."
                    return 1
                fi
                ;;
            --help|-h)
                show_help
                return 0
                ;;
            *)
                echo "Error: Unknown option '$1'"
                return 1
                ;;
        esac
    done

    # Validate only one environment option is used
    if [[ $options_count -gt 1 ]]; then
        echo "Error: Only one environment option (e.g., --dev, -c) can be used."
        return 1
    fi

    # Build full source path
    env_file=".env.${env}"
    local source_path="${temp_dir}${env_file}"

    # Check if source file exists
    if [[ ! -f "$source_path" ]]; then
        echo "Error: File '$source_path' does not exist."
        return 1
    fi

    # Dry-run (print) or execute (override .env)
    echo "Environment: $env"
    if [[ $dry_run -eq 1 ]]; then
        cat "$source_path"
    else
        cp "$source_path" ./.env
    fi
}

function gitclean() {
    local skip_confirm=false

    # Parse arguments
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            --skip) skip_confirm=true ;;
            *) echo "Unknown option: $1" >&2; return 1 ;;
        esac
        shift
    done

    # Get branches to be deleted
    local branches_to_delete=$(git branch --merged | grep -v -E "(^\*|main|dev|stage|ivanov)")

    # If no branches to delete, exit
    if [[ -z "$branches_to_delete" ]]; then
        echo "No merged branches to clean up."
        return 0
    fi

    # Preview branches
    echo "Branches to be deleted:"
    echo "$branches_to_delete"

    # Confirm unless --skip is used
    if [[ "$skip_confirm" = false ]]; then
        read -p "Do you want to delete these branches? (y/N) " confirm
        if [[ "$confirm" != [yY] && "$confirm" != [yY][eE][sS] ]]; then
            echo "Branch cleanup canceled."
            return 0
        fi
    fi

    # Delete branches
    echo "$branches_to_delete" | xargs git branch -d
}

function goto() {
    local config_file="C:/Users/stefan.boicu/.config/project_paths/config.txt"
    local home_file="C:/Users/stefan.boicu/.config/project_paths/home.txt"
    local target_alias=${1:-home}

    if [ -f "$config_file" ]; then
        local path=$(grep "^${target_alias}=" "$config_file" | cut -d'=' -f2)
        if [ -n "$path" ]; then
            cd "${path/#\~/$HOME}"
        else
            local home_path=$(grep "^home=" "$home_file" | cut -d'=' -f2)
            if [ -n "$home_path" ]; then
                cd "${home_path/#\~/$HOME}"
            fi
        fi
    fi
}

function saveto() {
    local config_file="$HOME/.config/project_paths/config.txt"
    local alias_name="$1"

    if [[ -n "$alias_name" ]]; then
        mkdir -p "$(dirname "$config_file")"
        local current_path="${PWD/#$HOME/\~}"
        sed -i "/^${alias_name}=/d" "$config_file" 2>/dev/null
        echo "${alias_name}=${current_path}" >> "$config_file"
    fi
}

function hometo() {
    local home_file="C:/Users/stefan.boicu/.config/project_paths/home.txt"
    local current_path="${PWD/#$HOME/\~}"
    echo "home=${current_path}" > $home_file 
}

# function startnotifications () {
# 	CURRENT_DIR=$(pwd)
# 	cd /c/Users/stefan.boicu/PycharmProjects/notifications-app
# 	docker compose up --wait -d ebs-notification-postgres ebs-notification-redis
# 	source .venv/Scripts/activate
# 	python manage.py runserver 8093
# 	deactivate
# 	cd $CURRENT_DIR
# 	unset $CURRENT_DIR
# }