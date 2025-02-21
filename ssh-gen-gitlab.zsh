#!/bin/zsh


TOKEN_GITLAB="put your token here"  
TITULO_CHAVE="SSH-KEY - $(hostname)"
SSH_KEY_PATH="$HOME/.ssh/id_rsa.pub"
GITLAB_API_URL="https://gitlab.com/api/v4/user/keys"
E-MAIL="put your email here"


if [ ! -f "$SSH_KEY_PATH" ]; then
    echo "🔑 Chave não encontrada, gerando nova chave..."
    ssh-keygen -t rsa -b 4096 -C "$E-MAIL" -f "$HOME/.ssh/id_rsa" -N ""
else
    echo "✅ Chave já existe."
fi


SSH_KEY=$(cat "$SSH_KEY_PATH")

echo "Enviando chave SSH para o GitLab..."


RESPONSE=$(curl --silent --request POST \
    --header "PRIVATE-TOKEN: $TOKEN_GITLAB" \
    --data-urlencode "title=$TITULO_CHAVE" \
    --data-urlencode "key=$SSH_KEY" \
    "$GITLAB_API_URL")


if echo "$RESPONSE" | grep -q '"id":'; then
    echo "🎉 Chave SSH adicionada com sucesso ao GitLab!"
else
    echo "Falha ao adicionar chave SSH ao GitLab. Resposta da API:"
    echo "$RESPONSE"
fi

#final check

ssh -T git@gitlab.com