#!/bin/bash

: '
Decided to do this bash script because whenever
I tried to take input from console on Replit
it automatically executed the whole program
without waiting for my arguments.
'

read -r user_x user_y coffee_shops_file

swiftc main.swift Services/*.swift Models/*.swift -o main
./main "$user_x" "$user_y" "$coffee_shops_file"