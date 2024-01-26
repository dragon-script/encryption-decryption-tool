#!/bin/bash

encrypt() {
    plaintext=$1
    key=$2
    encrypted=$(echo -n "$plaintext" | openssl enc -aes-256-cbc -a -salt -pass pass:"$key")
    echo "$encrypted"
}

decrypt() {
    encrypted=$1
    key=$2
    decrypted=$(echo -n "$encrypted" | openssl enc -d -aes-256-cbc -a -salt -pass pass:"$key" 2>/dev/null)
    echo "$decrypted"
}

echo "Encryption/Decryption Tool"

read -p "Enter encryption key: " encryption_key

while true; do
    echo -e "\n1. Encrypt"
    echo "2. Decrypt"
    echo "3. Exit"
    
    read -p "Choose an option (1/2/3): " choice

    case $choice in
        1)
            read -p "Enter text to encrypt: " text_to_encrypt
            encrypted_text=$(encrypt "$text_to_encrypt" "$encryption_key")
            echo -e "Encrypted Text: $encrypted_text\n"
            ;;
        2)
            read -p "Enter text to decrypt: " text_to_decrypt
            decrypted_text=$(decrypt "$text_to_decrypt" "$encryption_key")
            
            if [ -z "$decrypted_text" ]; then
                echo "Decryption failed. Incorrect key or input."
            else
                echo -e "Decrypted Text: $decrypted_text\n"
            fi
            ;;
        3)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please choose 1, 2, or 3."
            ;;
    esac
done
