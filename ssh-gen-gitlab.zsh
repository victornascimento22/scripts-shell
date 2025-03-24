#!/bin/zsh


TOKEN_GITLAB="put your token here"  
TITULO_CHAVE="SSH-KEY - $(hostname)"
SSH_KEY_PATH="$HOME/.ssh/id_rsa.pub"
GITLAB_API_URL="https://gitlab.com/api/v4/user/keys"
E-MAIL="put your email here"


if [ ! -f "$SSH_KEY_PATH" ]; then
    echo "no key found, generating new key"
    ssh-keygen -t rsa -b 4096 -C "$E-MAIL" -f "$HOME/.ssh/id_rsa" -N ""
else
    echo "key exists"
fi


SSH_KEY=$(cat "$SSH_KEY_PATH")

echo "send ssh key to gitlab"


RESPONSE=$(curl --silent --request POST \
    --header "PRIVATE-TOKEN: $TOKEN_GITLAB" \
    --data-urlencode "title=$TITULO_CHAVE" \
    --data-urlencode "key=$SSH_KEY" \
    "$GITLAB_API_URL")

if echo "$RESPONSE" | grep -q '"id":'; then
    echo "ssh key added on gitlab"
else
    echo "error, api response:"
    echo "$RESPONSE"
fi

#final check

ssh -T git@gitlab.com


if echo "$RESPONSE" | grep -q '"id":'; then
    echo "ssh key added on gitlab"
else
    echo "error, api response:"
    echo "$RESPONSE"
fi

#final check

ssh -T git@gitlab.com
