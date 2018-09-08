#!/bin/bash

# Checking if django is installed
python -c "import django; print(django.__path__)" &> /dev/null
status=$(echo $?)
if [ ${status} == 1 ];
  then echo "Django package is NOT installed.";
  else
    # Assigning values to variables
    export SECRET_KEY=$(python create_secrets.py);
    export SECRET_DB=$(python create_secrets.py);
fi
# Checking if variables received values.
if [ ${#SECRET_KEY} == 50 ]; then echo "the SECRET_KEY was set."; else echo "the SECRET_KEY was NOT set."; fi
if [ ${#SECRET_DB} == 50 ]; then echo "the SECRET_DB was set."; else echo "the SECRET_DB was NOT set."; fi
