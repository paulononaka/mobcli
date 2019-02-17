echo "Before: $PATH"

echo $PATH | grep -q "$HOME/scripts"

if [ $? -eq 0 ]; then
  PATH=$PATH:$HOME/scripts
  export PATH
else
  export PATH
fi

echo ""
echo "After: $PATH"