#!/bin/bash

: '
Decided to do this bash script because whenever
I tried to take input from console on Replit
it automatically executed the whole program
without waiting for my arguments.
'

read user_input

swiftc main.swift Services/*.swift Models/*.swift -o main
./main "$user_input"