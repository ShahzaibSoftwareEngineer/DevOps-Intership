#!/bin/bash
name="Shahzaib"
echo "Welcome $name!"
if [ -d "/home/$USER/Desktop" ]; then
  echo "Desktop directory exists."
else
  echo "Desktop directory not found."
fi

