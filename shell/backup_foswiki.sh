# All files have been moved to new server: 172.22.28.19, 2011-08-26, Herry Wang
DATE=`date +%Y%m%d%H%M%S`
echo "back up foswiki to ~/Backup/foswiki"
rsync -vzrtopg --progress -delete -e ssh hailwang@172.22.28.19:/var/www/html/foswiki /home/herry/Backup/foswiki/ > /home/herry/Backup/foswiki.$DATE

#rsync -vzrtopg --progress -delete -e ssh hailwang@10.74.61.77:/var/www/html/foswiki /home/hailwang/Backup/foswiki/ > /home/hailwang/Backup/foswiki.$DATE
#echo "back up cvs"
#rsync -vzrtopg --progress -delete -e ssh hailwang@10.74.61.125:/home/cvs/cvsroot /home/hailwang/Backup/cvs/$DATE > /home/hailwang/Backup/rsync.$DATE

