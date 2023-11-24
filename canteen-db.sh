#!/bin/bash

# Function to execute a MySQL query and print the results
execute_query() {

  local query=$1
  mysql -u "jarif" -p"1234qwer" "canteen" -e "$query"

}
execute_silent() {

  local query=$1
  mysql -u "jarif" -p"1234qwer" "canteen" -se "$query"

}

create_db(){
  execute_query "CREATE DATABASE canteen"
}
create_table(){
  execute_query "CREATE TABLE canteen.items (
    id INT NOT NULL AUTO_INCREMENT , 
    name VARCHAR(128) NOT NULL , 
    price DOUBLE NOT NULL , 
    stock INT NOT NULL , 
    PRIMARY KEY (id))"
}

# Function to insert data into a table

insert_data() {

    local nname=$1
    local pprice=$2
    local sstock=$3
    # local ex=0

    # local x=execute_query "SELECT id FROM items WHERE name='$nname'"

    exist=$(execute_silent "SELECT id FROM items WHERE name='$nname'")
    echo "$exist"
    if [[ $exist ]]; then
      # update_stock
      local oldStock=$(execute_silent "SELECT stock FROM items WHERE name='$nname'")
      local newStock=$(($oldStock + $sstock))
      update_stock $exist $newStock
      echo "$nname has been refilled by $sstock"
    else
      execute_query "INSERT INTO items (name, price, stock) VALUES ('"$nname"', $pprice, $sstock)"
      echo "$name added successfully."
    fi

}

#mysql> INSERT INTO items (name, price, stock) VALUES ("burger", 100, 5);

# Function to update stock in a table
update_stock() {

    local item=$1
    local value=$2
    execute_query "UPDATE items SET stock = '$value' WHERE id=$item"

}

# Function to delete an item from a table
delete_item() {

    read item
    execute_query "DELETE FROM items WHERE id=$item"

}

# Function to display the menu
display_menu() {

  execute_query "SELECT * FROM items"

}

# Function to add a new dish
add_dish() {


  echo "Enter the name of the dish: "
  read name

  echo "Enter the price of the dish: "
  read price

  echo "Enter the stock of the dish: "
  read stock

  insert_data $name $price $stock

}

# Function to place an order
place_order() {
  echo "Enter the dish number: "
  read dish_number

  echo "Enter the quantity: "
  read quantity

  local stock=$(execute_silent "SELECT stock FROM items WHERE id='$dish_number'")

  if [[ $stock -lt $quantity ]]; then
    local name=$(execute_silent "SELECT name FROM items WHERE id='$dish_number'")
    echo "sorry, we only have $stock $name"
    else
      price=$(execute_silent "SELECT price FROM items WHERE id='$dish_number'")

      # total=$(expr $((prices[$dish_number-1])) \* $quantity)
      total=$(($price * $quantity))

      echo "Order Details:"
      echo "Dish: $dish_number"
      echo "Quantity: $quantity"
      echo "Total Price: $total"
      echo "Order placed successfully."

      local newStock=$(($stock - $quantity))
      update_stock $dish_number $newStock
    fi
}

# Main menu loop
while true; do
  echo "Restaurant Management System"
  echo "1. Add a new dish"
  echo "2. Display the menu"
  echo "3. Delete an item"
  echo "4. Place an order"
  echo "5. Exit"

  echo "Enter your choice: "
  read choice

  case $choice in
    1)
      add_dish
      ;;
    2)
      display_menu
      ;;
    3)
      delete_item
      ;;
    4)
      place_order
      ;;
    5)
      echo "Exiting..."
      exit 0
      ;;
    6)
      create_table
      ;;
    *)
      echo "Invalid choice. Please try again."
      ;;
  esac

  echo
done