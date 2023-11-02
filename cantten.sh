#!/bin/bash

# Function to add a new dish
i=1
declare -a items
declare -a prices
add_dish() {
  echo "Enter the name of the dish: "
  read name
  items+=("$name")

  echo "Enter the price of the dish: "
  read price
  prices+=("$price")

  # echo "$i. $name, $price" >> menu.txt
  # ((i=i+1))
  echo "Dish added successfully."
}

# Function to display the menu
display_menu() {
  echo "Menu:"
  echo "Dish Name, Price"
  # cat menu.txt
  echo "${ items[@]}"
}

# Function to search for a dish
search_dish() {
  echo "Enter the name of the dish: "
  read name

  grep -i "$name" menu.txt
}

# Function to place an order
place_order() {
  echo "Enter the dish name: "
  read dish_number

  echo "Enter the quantity: "
  read quantity

  price=$(grep -i "$dish_number." menu.txt | cut -d ',' -f 2)
  total=$(expr $price \* $quantity)

  echo "Order Details:"
  echo "Dish: $dish_name"
  echo "Quantity: $quantity"
  echo "Total Price: $total"
  echo "Order placed successfully."
}

# Main menu loop
while true; do
  echo "Restaurant Management System"
  echo "1. Add a new dish"
  echo "2. Display the menu"
  echo "3. Search for a dish"
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
      search_dish
      ;;
    4)
      place_order
      ;;
    5)
      echo "Exiting..."
      exit 0
      ;;
    *)
      echo "Invalid choice. Please try again."
      ;;
  esac

  echo
done