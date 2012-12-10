tmux has-session -t sif-wd
if [ $? != 0 ]
then
  tmux new-session -d -s sif-wd
  tmux new-window -t sif-wd:1 -n "centos5" "ssh root@vs-centos-5"
  tmux new-window -t sif-wd:2 -n "centos6" "ssh root@vs-centos-6" 
  tmux new-window -t sif-wd:3 -n "centos7" "ssh root@vs-centos-7" 
  tmux select-window -t sif-wd:0 
fi
tmux -2 attach-session -t sif-wd
