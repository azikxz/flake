{ pkgs }:

pkgs.writeShellScriptBin "whdl" ''
  cmd="wget -cq --show-progress --limit-rate=10M --timeout=5 --tries=3"
  if [[ "$1" == *.png ]] || [[ "$1" == *.jpeg ]] || [[ "$1" == *.jpg ]]; then
    if    [[ "$2" == *.png  ]];  then  $cmd $2 -O $1 
    elif  [[ "$2" == *.jpg  ]];  then  $cmd $2 -O $1
    elif  [[ "$2" == *.jpeg ]];  then  $cmd $2 -O $1 
    else  echo "omg xd"
    fi
  elif [[ "$1" == * ]] || [[ "$1" == * ]] || [[ "$1" == * ]]; then
    if    [[ "$2" == *.png  ]];  then  $cmd $2 -O $1.png
    elif  [[ "$2" == *.jpg  ]];  then  $cmd $2 -O $1.jpg
    elif  [[ "$2" == *.jpeg ]];  then  $cmd $2 -O $1.jpeg
    else  echo "omg xd"
    fi
  fi
''
