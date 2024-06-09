GITHUB_AUTH_TOKEN=<AddYourGithubToken>

gitcreate(){
    #Enter name , commit msg
    echo "enter repository name"
    read REPO_NAME

    echo "enter first commit message"
    read COMMIT_MESSAGE

    # #Obtain the username
    GIT_USER_NAME=$(git config --get user.name)

    #Create the remote repository
    curl -L \
    -X POST \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $GITHUB_AUTH_TOKEN" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/user/repos \
    -d "{\"name\":\"$REPO_NAME\",\"homepage\":\"https://github.com\",\"private\":true}"

    #Push the changes
    git init
    git remote add origin https://github.com/$GIT_USER_NAME/$REPO_NAME.git
    git remote set-url origin https://$GITHUB_AUTH_TOKEN@github.com/$GIT_USER_NAME/$REPO_NAME.git
    git add .
    git commit -m "$COMMIT_MESSAGE"
    git push origin master
}