git push cgit
#origin is set to github, so after push, the commit will be seen in github.
git push
#cd ../cgit
#run git pull to get latest
#then the changes will be seen in the cgit website.
#remote sample:

#git remote -v
#cgit    git@git.herry-desktop.cisco.com:scripting (fetch)
#cgit    git@git.herry-desktop.cisco.com:scripting (push)
#origin  git@github.com:herry1234/scripting.git (fetch)
#origin  git@github.com:herry1234/scripting.git (push)


#-------How to create new repo in cgit -----

#1. add one entry in ../gitolite-admin/conf/gitolite.conf
#2. commit and push the change, at this point, this new empty repo can be seen in cgit
#3. push the repo to cgit.
#example:  git push --all git@git.herry-desktop.cisco.com:tnc-apps
#--all is required, tnc-apps is the repo name defined in conf/gitolite.conf
#also we can add one remote in your repo, like the sample for project 'scripting'. 
#next time when running git push 'your_cgit_remote_name', all the changes could be push to cgit. 



