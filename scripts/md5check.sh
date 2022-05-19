#!/bin/bash
c=$(pwd)
echo "Current directory:$c"
echo ""
echo ""
echo "$(date "+%Y-%m-%d %H:%M:%S")  Starting check file integrity"
md5sum="/usr/bin/md5sum"

ls |grep Sample|while read id;do cd $id && ${md5sum} -c *md5 && cd .. ;done

echo ""
echo "$(date "+%Y-%m-%d %H:%M:%S")  ALL DONE"
