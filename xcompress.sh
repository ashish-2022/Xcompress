#!/bin/sh
# -----------------------------------------------------------------------------
# A simple utility to compress or extract any UNIX archive
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
  echo ""
  echo "A simple utility to compress or extract any UNIX archive."
  echo ""
  echo "Usage:"
  echo "   $0 -c|x -t <compression_type> -f <file/directory>"
  echo ""
  echo "   c = compress"
  echo "   x = extract"
  echo "   f = file or folder name"
  echo "   t = type of archive (tar|tar.gz|tar.bz2|tar.xz|tbz|zip|cbz...etc)"
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
   "tar")
   if [ $create == 1 ]
   then
   tar -cvf $file.$ftype $file
   elif [ $extract == 1 ]
   then
   tar -xvf $file
   fi
   ;;
   "tar.gz"|"tgz")
   if [ $create == 1 ]
   then
   tar -cvzf $file.$ftype $file
   elif [ $extract == 1 ]
   then
   tar -xvzf $file
   fi
   ;;
   "tar.Z")
   if [ $create == 1 ]
   then
   tar -cvZf $file.$ftype $file
   elif [ $extract == 1 ]
   then
   tar -xvZf $file
   fi
   ;;
   "tar.bz2"|"tbz"|"tar.gz2"|"tar.bz")
   if [ $create == 1 ]
   then
   tar -cvjf $file.$ftype $file
   elif [ $extract == 1 ]
   then
   tar -xvjf $file
   fi
   ;;
   "tar.xz")
   if [ $create == 1 ]
   then
   tar -cvJf $file.$ftype $file
   elif [ $extract == 1 ]
   then
   tar -xvJf $file
   fi
   ;;
   "zip")
   if [ $create == 1 ]
   then
   zip -r $file.$ftype $file
   elif [ $extract == 1 ]
   then
   unzip $file
   fi
   ;;
   "7z"|"cbz"|"cbr")
   if [ $create == 1 ]
   then
   7z a -t7z $file.$ftype $file
   elif [ $extract == 1 ]
   then
   7z x $file
   fi
   ;;
   "gz")
   if [ $create == 1 ]
   then
   gzip -9 $file
   elif [ $extract == 1 ]
   then
   gunzip $file
   fi
   ;;
   "bz2")
   if [ $create == 1 ]
   then
   bzip2 -z $file
   elif [ $extract == 1 ]
   then
   bzip2 -d $file
   fi
   ;;
   "xz")
   if [ $create == 1 ]
   then
   xz -z $file
   elif [ $extract == 1 ]
   then
   xz -d $file
   fi
   ;;
   "Z")
   if [ $create == 1 ]
   then
   compress $file
   elif [ $extract == 1 ]
   then
   compress -d $file
   fi
   ;;
esac

# End of file

