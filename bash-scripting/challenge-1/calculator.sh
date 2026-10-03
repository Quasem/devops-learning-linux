#!/bin/bash
# Challenge 1: Simple Calculator
#Create a script that takes two numbers as input and performs basic arithmetic operations (addition, subtraction, multiplication, division).
#Requirements:

#Prompt user for two numbers
#Perform all four operations
#Display the results
#Handle division by zero
#Example output:
#Enter first number: 10 Enter second number: 5

#Results: 10 + 5 = 15 10 - 5 = 5 10 × 5 = 50 10 ÷ 5 = 2

# Prompt user for two numbers
read -p "Enter first number: " num1
read -p "Enter second number: " num2 

if ! [[ $num1 =~ ^-?[0-9]+$ ]]; then
    echo "Error: '$num1' is not a valid whole number" >&2
    exit 1
fi

if ! [[ $num2 =~ ^-?[0-9]+$ ]]; then
    echo "Error: '$num2' is not a valid whole number" >&2
    exit 1
fi

result_add=$((num1 + num2))
result_sub=$((num1 - num2))
result_mul=$((num1 * num2))
# Handle division by zero
if [ "$num2" -ne 0 ]; then
    result_div=$(echo "scale=2; $num1 / $num2" | bc)
else
    result_div="undefined (division by zero)"
fi      

# Display the results
echo "Results:"
echo "$num1 + $num2 = $result_add"
echo "$num1 - $num2 = $result_sub"
echo "$num1 × $num2 = $result_mul"
echo "$num1 ÷ $num2 = $result_div"     

read -p "Press Enter to exit..."   

