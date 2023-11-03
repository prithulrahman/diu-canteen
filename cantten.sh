#!/bin/bash

# Function to add a new dish
n=0
declare -a items
declare -a prices
add_dish() {
  echo "Enter the name of the dish: "
  read name
  items+=("$name")

  echo "Enter the price of the dish: "
  read price
  prices+=("$price")

  ((n=n+1))
  echo "Dish added successfully."
}

# Function to display the menu
display_menu() {
  echo "Menu:"
  echo "Dish Name........ Price"
  for (( i=0 ; i<$n ; i++ )); 
  do
    echo "$(($i+1)). ${items[$i]}........ ${prices[$i]}"
  done
}

# Function to search for a dish
search_dish() {
  echo "Enter the name of the dish: "
  read name

  for (( i=0 ; i<$n ; i++ )); 
  do
    if [ ${items[$i]} == $name ]; then
      echo "$(($i+1)). ${items[$i]}........ ${prices[$i]}"
    else
      echo "$name not found"
    fi
  done
}

# Function to place an order
place_order() {
  echo "Enter the dish number: "
  read dish_number

  echo "Enter the quantity: "
  read quantity

  total=$(expr $((prices[$dish_number-1])) \* $quantity)

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