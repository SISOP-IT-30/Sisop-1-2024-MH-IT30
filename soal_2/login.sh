# Function to check if a string is empty
is_empty() {
    if [ -z "$1" ]; then
        return 0   # empty
    else
        return 1   # not empty
    fi
}

# Function to check if email is valid
is_valid_email() {
    local email_regex="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
    if [[ $1 =~ $email_regex ]]; then
        return 0   # valid
    else
        return 1   # invalid
    fi
}

# Function to check if password meets security requirements
is_valid_password() {
    local password="$1"
    local length=${#password}
    local has_uppercase=$(echo "$password" | grep -q '[[:upper:]]' && echo true || echo false)
    local has_lowercase=$(echo "$password" | grep -q '[[:lower:]]' && echo true || echo false)
    local has_digit=$(echo "$password" | grep -q '[[:digit:]]' && echo true || echo false)

    if [ $length -ge 8 ] && [ "$has_uppercase" == true ] && [ "$has_lowercase" == true ] && [ "$has_digit" == true ]; then
        return 0   # valid
    else
        return 1   # invalid
    fi
}

# Function to check if user exists in users.txt
user_exists() {
    local email="$1"
    if grep -q "^$email:" users.txt; then
        return 0   # exists
    else
        return 1   # does not exist
    fi
}

# Function to retrieve stored password from users.txt
get_stored_password() {
    local email="$1"
    local stored_password=$(grep "^$email:" users.txt | cut -d ':' -f 5)
    echo "$stored_password"
}

# Function to log messages to auth.log
log_message() {
    local type="$1"
    local message="$2"
    local date_time=$(date +"%d/%m/%y %T")
    echo "[$date_time] [$type] $message" >> auth.log
}

echo "Choose an option:"
echo "1. Login"
echo "2. Forgot Password"

read choice

if [ "$choice" == "1" ]; then
    echo "Enter your email: "
    read email
    echo "Enter your password: "
    read -s password

    if is_empty "$email" || is_empty "$password"; then
        log_message "LOGIN FAILED" "ERROR Empty email or password"
        echo "Error: Email and password cannot be empty."
        exit 1
    fi

    # Check if user exists
    if user_exists "$email"; then
        stored_password=$(get_stored_password "$email")
        if [ "$password" == "$(echo -n "$stored_password" | base64 -d)" ]; then
            log_message "LOGIN SUCCESS" "User with email $email logged in successfully"
            echo "Login successful!"
        else
            log_message "LOGIN FAILED" "ERROR Incorrect password for user with email $email"
            echo "Error: Incorrect email or password."
            exit 1
        fi
    else
        log_message "LOGIN FAILED" "ERROR User with email $email does not exist"
        echo "Error: User with email $email does not exist."
        exit 1
    fi
elif [ "$choice" == "2" ]; then
    # Password recovery functionality can be implemented here
    echo "Forgot Password functionality not implemented yet."
    exit 0
else
    echo "Invalid choice. Please choose 1 or 2."
    exit 1
fi
