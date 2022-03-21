#!/bin/bash

# Verificando se os aplicativos necesários estão instalados
if [ ! $(command -v vim) ]; then
    sudo apt-get update && apt-get install -y vim
fi

if [ ! $(command -v git) ]; then
   sudo apt-get update && apt-get install -y git
fi

echo -ne "Usuário que deseja configurar o VIM: "
read username

user_data=$(grep -w $username /etc/passwd)

# Verifica se user_data é uma string vazia
# -n retorna zero caso NÃO seja vazia
# -z retorna zero caso SEJA vazia
if [[ -z $user_data ]] ; then
    echo "O usuário não existe!"
    exit 0
fi

# Verifica se os diretórios necessários existem
if [ -d /home/$username/.vim ]; then
    echo -ne "O diretório .vim existe. Deseja excluir antes de continuar? [S/n]: "
    read user_choice

    if [ $user_choice = 'N' -o $user_choice = 'n' ]; then
        exit 0
    else
        echo "Passando para testes"
#        rm -rf /home/$username/.vim
    fi
fi

# Verifica se o arquivo .vimrc existe e não está vazio
if [ -e /home/$username/.vimrc -a -s /home/$username/.vimrc ]; then
    echo -ne "O arquivo .vimrc existe e contem dados. Deseja exclui-lo? [S/n]: "
    read user_choice
    
    elif [ $user_choice = 'N' -o $user_choice = 'n' ]; then
        exit 0
    elif [ $user_choice = 'S' -o $user_choice = 's']; then
        rm -f /home/$username/.vimrc
    else
        echo "Opção desconhecida!"
        exit 0
    fi
else
    echo "O arquivo não existe ou está vazio!"
fi

exit 0