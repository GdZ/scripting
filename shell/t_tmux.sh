tmux has-session -t sif
if [ $? != 0 ]
then
  tmux new-session  -s sif -n ssh -d "ssh root@ss-auto-centos-6"
  #tmux rename-window 'ssh'
  tmux list-windows
  tmux select-window -t sif:ssh
  tmux split-window  -h "ssh root@vs-centos-5"
  tmux split-window  -t 0 -v "ssh root@vs-centos-6" 
  tmux split-window  -t 1 -v "ssh root@vs-centos-7" 
  tmux new-window -n magento "ssh root@ss-auto-centos-4"
  tmux split-window  -t :magento -h "ssh hailwang@smbu-lab-lnx1"
fi
echo "Sessions: "
tmux list-sessions
echo "Windows: "
tmux list-windows
echo "Panes: "
tmux list-panes

#choose window
tmux select-window -t sif:ssh
#CMD="cd \$(  ps -ef |grep jboss_init | grep sh | awk -F' ' '{print \$9}' | sed  's/[^\/]\+$//' )"
CMD="cd \$(ps -ef |grep bin/run.sh | grep opencase | awk -F' ' '{print \$9}' | sed  's/[^\/]\+$//' )"
tmux send-keys -t 1 "$CMD" C-m
tmux send-keys -t 2 "$CMD" C-m
tmux send-keys -t 3 "$CMD" C-m

# attach it as last step
tmux attach -t sif
