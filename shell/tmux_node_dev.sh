tmux has-session -t app
if [ $? != 0 ]
then
  tmux new-session  -s app -n dev -d "bash"
  tmux list-windows
  tmux select-window -t app:dev
  tmux split-window  -h "bash"
  tmux split-window  -t 1 -v "bash" 
fi
echo "Sessions: "
tmux list-sessions
echo "Windows: "
tmux list-windows
echo "Panes: "
tmux list-panes
#choose window
tmux select-window -t app:dev
CMD="cd /home/herry/workspace/noderest"
tmux send-keys -t 0 "$CMD" C-m
tmux send-keys -t 1 "$CMD" C-m
tmux send-keys -t 2 "$CMD" C-m

# attach it as last step
tmux attach -t app
