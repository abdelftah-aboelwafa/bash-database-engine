#!/usr/bin/bash 
mkdir -p DB
cd DB
select option in list_db connect_db create_db drop_db exit
do 
    case $REPLY in
    1)
    echo "Databases:"
    ls -d */ 2>/dev/null
    ;;
    2)
    echo "Databases available are:"
    ls -d */ 2>/dev/null

    read -p "Enter Database Name: " dbname
    if [ -d "$dbname" ]; then
        cd "$dbname"
        echo "Connected to $dbname"

        if [ -f "../../connect.sh" ]; then
            bash "../../connect.sh"
        else
            echo "Error: connect.sh not found at ../../connect.sh"
        fi
    else
        echo "Database '$dbname' not found."
    fi
    ;;
    3)
    while true
    do
    read -p "Enter Database Name: " dbname
    if [[ "$dbname" =~ ^[a-zA-Z0-9_]+$ ]]; then
    break
    else
    echo "Invalid name! Use only letters, numbers or underscore. No spaces or symbols."
    fi
    done
     mkdir -p "$dbname"
    echo "Database $dbname Created"
    ;;
    4)
    echo "Databases availables are :"
    ls -d */ 2>/dev/null
    read -p "Enter Database Name: " dbname
    if [[ -d $dbname ]];
    then
        echo "are you sure want to remove datebase type  y or Y "
        read ans
        if [[ $ans == "y" || $ans == "Y" ]];
        then 
        rm -r "$dbname"
        echo "Database Deleted"
        else 
            echo " datebase don't delete "
        fi
    else
        echo " datebase not exist "
    fi

    ;;
     5)
        break
        ;;
    *)
        echo "Invalid option"
        ;;
    esac
done 

