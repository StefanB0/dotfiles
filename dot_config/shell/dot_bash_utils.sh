### Utils ###

#mkdir
function mcd () {
	mkdir -pv $1
	cd $1
}

function mtouch () {
	# Check if at least one argument is provided
	if [ "$#" -eq 0 ]; then
		echo "Usage: $0 <file1> [<file2> ... <fileN>]"
		exit 1
	fi
	
	# Iterate over each argument
	for arg in "$@"; do
		# Create the parent directories if they don't exist
		\mkdir -p "$(dirname "$arg")"
		
		# Create the file
		touch "$arg"
		
		# Inform the user
		echo "Created file: $arg"
	done
}

# Generate merge requests
function ebs-pr() {
	# wt -d $(pwd) -p "Git Bash" "C:/Program Files/Git/bin/bash.exe" -i -l -c "aichat --macro merge-request && echo -e '\n\033[32mPress Enter to exit...\033[0m' && read"
	wt -d $(pwd) -p "Git Bash" "C:/Program Files/Git/bin/bash.exe" -i -l -c "aichat --macro merge-request && read"
}

# Function to compare two strings and highlight differences
function cmp-color() {
	STRING_A="$1"
	STRING_B="$2"

	# Define ANSI color codes
	RED='\033[0;31m'
	GREEN='\033[0;32m'
	NC='\033[0m'  # No color (reset)

	# Check if the strings are of the same length
	if [ ${#STRING_A} -ne ${#STRING_B} ]; then
		echo "Error: Strings must have the same length."
    echo -e "$STRING_A"
    echo -e "${RED}$STRING_B${NC}"
		exit 1
	fi


	# If strings are identical, print in green
	if [ "$STRING_A" = "$STRING_B" ]; then
		echo -e "${GREEN}$STRING_A${NC}"
	else
		# Otherwise, compare character by character and highlight differences in red
		outputA=""
		outputB=""
		for ((i=0; i<${#STRING_A}; i++)); do
			charA="${STRING_A:$i:1}"
			charB="${STRING_B:$i:1}"

			if [ "$charA" = "$charB" ]; then
				outputA+="${GREEN}$charA${NC}"
				outputB+="${GREEN}$charB${NC}"
			else
				outputA+="${RED}$charA${NC}"
				outputB+="${RED}$charB${NC}"
			fi
		done
		echo -e "$outputA"
		echo -e "$outputB"
	fi
}
