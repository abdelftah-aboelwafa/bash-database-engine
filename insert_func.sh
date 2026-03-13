#!/usr/bin/bash

insert_record() {

while true; do
read -p "Enter id: " id

if [[ -z "$id" ]]; then
echo "ID cannot be empty!"
continue
fi

if [[ ! "$id" =~ ^[0-9]+$ ]]; then
echo "ID must be a number!"
continue
fi

if grep -q "^$id:" "$table"; then
echo "ID already exists!"
continue
fi

break
done


while true; do
read -p "Enter username: " username

if [[ -z "$username" ]]; then
echo "Username cannot be empty!"
continue
fi

if [[ ! "$username" =~ ^[a-zA-Z0-9]+$ ]]; then
echo "Username cannot contain spaces or special characters!"
continue
fi

break
done


while true; do
read -p "Enter email: " email

if [[ -z "$email" ]]; then
echo "Email cannot be empty!"
continue
fi

if [[ "$email" =~ [[:space:]] ]]; then
echo "Email cannot contain spaces!"
continue
fi

if [[ ! "$email" =~ ^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.com$ ]]; then
echo "Invalid email format ! exampe : abdelftahelsayed@yahoo.com "
continue
fi

break
done


while true; do
read -p "Enter password: " password

if [[ -z "$password" ]]; then
echo "Password cannot be empty!"
continue
fi

if [[ "$password" =~ [[:space:]] ]]; then
echo "Password cannot contain spaces!"
continue
fi

break
done


echo "$id:$username:$email:$password" >> "$table"
echo "Record inserted successfully!"

}