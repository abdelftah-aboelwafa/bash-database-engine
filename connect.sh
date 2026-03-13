#!/usr/bin/bash
source ../../insert_func.sh

echo "Connected to $(basename $PWD)"

select option in create_table list_tables drop_table insert_into_table select_from_table delete_from_table back
do
    case $REPLY in
    1)
    while true; do
    read -p "Enter table name to create: " table

    if [[ ! "$table" =~ ^[a-zA-Z0-9_]+$ ]]; then
        echo "Invalid table name! Only letters, numbers, and _ are allowed. No spaces."
        continue
    fi

    if [[ -f "$table" ]]; then
        echo "Table '$table' already exists! Please enter a different name."
        continue
    fi

    touch "$table"
    echo "Table '$table' created successfully!"
    break
done

read -p "Do you want to insert data now? (y/n): " ans

if [[ "$ans" == "y" || "$ans" == "Y" ]]; then
insert_record
fi
;;
    2)
       tables=$(ls -1 2>/dev/null)

    if [[ -z "$tables" ]]; then
        echo "No tables found!"
        exit 0
    else
        echo "Tables available:"
        echo "$tables"
    fi

    read -p "Enter table name to view: " table

    if [[ ! -f "$table" ]]; then
        echo "Table not found!"
    elif [[ ! -s "$table" ]]; then
        echo "Table is empty!"
    else
        echo "id : username : email : password"
        column -t -s : "$table"
    fi
    ;;
    3)
        echo "Tables available:"
        ls 2>/dev/null
         read -p "Enter table name to drop: " table
        if [[ -f "$table" ]]; then
            rm "$table"
            echo "Table '$table' deleted successfully!"
        else
            echo "Table not found!"
        fi
    ;;
    4)
    echo "Tables available:"
    ls 2>/dev/null

    echo "Insert Into Table"
    
    read -p "Enter table name: " table
    if [[ ! -f "$table" ]]; then
    echo "Table does not exist!"
    else
    insert_record
    fi
    ;;
    5)
                
        tables=$(ls -1 2>/dev/null)

        if [[ -z "$tables" ]]; then
            echo "No tables found!"
            exit 0
        else
            echo "Tables available:"
            echo "$tables"
        fi

        read -p "Enter table name: " table

        if [[ ! -f "$table" ]]; then
            echo "Table not found!"
        else
            if [[ ! -s "$table" ]]; then
                echo "Table is empty!"
                read -p "Do you want to insert data? (y/n): " ans

                if [[ "$ans" =~ ^[Yy]$ ]]; then
                    insert_record   
                fi
            else
                echo "id : username : email : password"
                column -t -s : "$table"
            fi
        fi 
        ;;
    6)
        echo "Tables available:"
        ls -1 2>/dev/null
         read -p "Enter table name to delete from: " table
        if [[ ! -f "$table" ]]; then
            echo "Table not found!"
        elif [[ ! -s "$table" ]]; then
            echo "Table is empty!"
        else
                echo "Current records:"
            awk -F: '{print $1 " : " $2 " : " $3 " : " $4}' "$table"

            read -p "Enter the ID of the record to delete: " del_id

            if grep -q "^$del_id:" "$table"; then
                awk -F: -v id="$del_id" '$1 != id' "$table" > temp && mv temp "$table"
                echo "Record with ID $del_id deleted successfully!"
            else
                echo "ID not found!"
            fi
        fi
        ;;
    7)
      cd ../..
    exec bash Db.sh
    ;;       
    *)
        echo "Invalid option"
        ;;
    esac
done