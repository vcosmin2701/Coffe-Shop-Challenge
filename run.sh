#!/bin/bash

: '
Decided to do this bash script because whenever
I tried to take input from console on Replit
it automatically executed the whole program
without waiting for my arguments.
'

echo "Please enter a file path or URL:"
read user_input

swiftc main.swift Services/CSVManager.swift Models/ECoffeeShop.swift -o main
./main "$user_input"