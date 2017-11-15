# Xcompress
A simple utility to compress or extract any UNIX archive.  
This utility gives user a uniform way to compress and extract all types of archives.  

Supported Types:  
tar, tar.gz, tgz, tar.bz, tar.bz2, tar.gz2, tar.Z, tbz, zip, 7z, tar.xz, gz, bz2, xz, cbr, cbz  

## Usage:

```
      ./xcompress.sh -c -t <compression_type> -f <file/directory>
```

## Compressing:

```
$ ls
MyDirectory  xcompress.sh

$ ./xcompress.sh -c -t tar.bz2 -f MyDirectory
MyDirectory/
MyDirectory/Sample.cpp
MyDirectory/Sample.h
MyDirectory/Sample1.java
MyDirectory/Sample1.txt

$ ls
MyDirectory  MyDirectory.tar.bz2  xcompress.sh
```

## Extracting:

```
$ ls
MyDirectory.tar.bz2  xcompress.sh

$ ./xcompress.sh -x -t tar.bz2 -f MyDirectory.tar.bz2
MyDirectory/
MyDirectory/Sample.cpp
MyDirectory/Sample.h
MyDirectory/Sample1.java
MyDirectory/Sample1.txt

$ ls
MyDirectory  MyDirectory.tar.bz2  xcompress.sh
```

