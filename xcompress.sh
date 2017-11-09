#!/bin/sh
# -----------------------------------------------------------------------------
# A simple utility to compress or extract any unix archive
# -----------------------------------------------------------------------------

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
file=""
create=0
extract=0
ftype="tar"

usage()
{
  echo "A simple utility to compress or extract any unix archive."
  echo "Usage: $0 -c/x -f <source> -t <type>"
  echo "   c = compress"
  echo "   x = extract"
  echo "   f = file or folder name"
  echo "   t = type of archive (tar|tar.gz|tar.bz2|tar.xz|zip)"
  echo ""
}

while getopts "h?cf:xt:" opt; do
    case "$opt" in
    h|\?)
        usage
        exit 0
        ;;
    c)  create=1
        ;;
    f)  file=$OPTARG
        ;;
    x)  extract=1
        ;;
    t)  ftype=$OPTARG
        ;;
    esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

# File name is mandatory
if [ -z $file ]
then
  echo "File name is mandatory"
  usage
  exit 0
fi

# Cannot compress and extract at same time
if [ $create = $extract ]
then
  echo "Cannot compress and extract at same time..."
  usage
  exit 0
fi

case "$ftype" in
   "tar") echo "Type is tar"
   if [ $create == 1 ]
   then
   tar -cvf $file.$ftype $file
   elif [ $extract == 1 ]
   then
   tar -xvf $file
   else
   echo "Unknown operation"
   fi
   ;;
   "tar.gz") echo "Type is tar.gz" 
   if [ $create == 1 ]
   then
   tar -cvzf $file.$ftype $file
   elif [ $extract == 1 ]
   then
   tar -xvzf $file
   else
   echo "Unknown operation"
   fi
   ;;
   "tar.bz2") echo "Type is tar.bz2" 
   if [ $create == 1 ]
   then
   tar -cvjf $file.$ftype $file
   elif [ $extract == 1 ]
   then
   tar -xvjf $file
   else
   echo "Unknown operation"
   fi
   ;;
   "tar.xz") echo "Type is tar.xz" 
   if [ $create == 1 ]
   then
   tar -cvJf $file.$ftype $file
   elif [ $extract == 1 ]
   then
   tar -xvJf $file
   else
   echo "Unknown operation"
   fi
   ;;
   "zip") echo "Type is zip"
   if [ $create == 1 ]
   then
   zip -r $file.$ftype $file
   elif [ $extract == 1 ]
   then
   unzip $file
   else
   echo "Unknown operation"
   fi
   ;;
esac

# End of file

