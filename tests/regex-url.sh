#!/bin/bash

regex='';
url='alexishenry.eu';

if [[ $url =~ $regex ]]
then 
    echo "$url IS valid"
else
    echo "$url IS NOT valid"
fi
