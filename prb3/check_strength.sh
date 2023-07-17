#!/bin/bash

function check_password_strength() {
    local password=$1

    if [ ${#password} -lt 10 ]; then
        echo "Password strength: Low (Minimum length should be 10 characters)."
        return
    fi

    if ! [[ "$password" =~ [[:upper:]] && "$password" =~ [[:lower:]] && "$password" =~ [[:punct:]] ]]; then
        echo "Password strength: Medium (Should include uppercase, lowercase, and special characters)."
        return
    fi

    if ! [[ "$password" =~ [[:digit:]] ]]; then
        echo "Password strength: High (Should include at least one digit)."
        return
    fi

    echo "Password strength: Strong."
}

echo "Enter your password: "
read -s password

check_password_strength "$password"
