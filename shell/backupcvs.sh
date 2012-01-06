DATE=`date +%Y%m%d%H%M%S`
rsync -vzrtopg --progress -delete -e ssh hailwang@10.74.61.125:/home/cvs/cvsroot /home/hailwang/Backup/cvs/$DATE > /home/hailwang/Backup/rsync.$DATE

