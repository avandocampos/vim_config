#!/bin/bash

# Atualizando as informações do repositório

if [ $(command -v dnf) ]; then
    dnf update -y
    # Verifica se os aplicativos necesários estão instalados
    if [ ! $(command -v vim) ]; then
        # apt-get install -y vim
        dnf install -y vim
    fi

    if [ ! $(command -v git) ]; then
        # apt-get install -y git
        dnf install -y git
    fi

    if [ ! $(command -v curl) ]; then
        # apt-get install -y curl
        dnf install -y curl
    fi
fi

if [ $(command -v apt) -a $(command -v apt-get) ]; then
    apt-get update
    
    # Verifica se os aplicativos necesários estão instalados
    if [ ! $(command -v vim) ]; then
        # apt-get install -y vim
        apt-get install -y vim
    fi

    if [ ! $(command -v git) ]; then
        # apt-get install -y git
        apt-get install -y git
    fi

    if [ ! $(command -v curl) ]; then
        # apt-get install -y curl
        apt-get install -y curl
    fi
fi

echo -ne "Digite o usuário para o qual deseja configurar o VIM: "
read username

user_data=$(grep -w $username /etc/passwd)

# Verifica se user_data é uma string vazia
# -n retorna zero caso NÃO seja vazia
# -z retorna zero caso SEJA vazia
if [[ -z $user_data ]] ; then
    echo "O usuário não existe!"
    echo "É necessário um usuário ativo para que a configuração seja aplicada."
    echo "Caso necessário, crie o usuário antes de executar o script."
    exit 0
fi

# Verifica se os diretórios necessários existem
# Caso exista, exclui com o consentimento do usuário
if [ -d /home/$username/.vim ]; then
    echo -ne "O diretório .vim já existe. Deseja excluir antes de continuar? [S/n]: "
    read user_choice

    if [ $user_choice = 'N' -o $user_choice = 'n' ]; then
        echo "É importando que nenhuma configuração anterior esteja aplicada para evitar conflito."
        echo "Faça backup do diretório .vim antes de tentar novamente e exclua-o."
        exit 0
    elif [ $user_choice = 'S' -o $user_choice = 's' ]; then
        echo "Excluindo o diretório .vim e os subdiretório nele contidos..."
        rm -rf /home/$username/.vim
    else
        echo "Opção desconhecida!"
        exit 0
    fi
fi

# Criando os diretórios que conterão os plugins.

echo "Criando os diretório ~/.vim/autoload e ~/.vim/bundle"
mkdir -p /home/$username/.vim/autoload 
mkdir -p /home/$username/.vim/bundle

# Verifica se o arquivo .vimrc existe e não está vazio
if [ -e /home/$username/.vimrc ]; then
    echo -ne "O arquivo .vimrc já existe. Deseja exclui-lo? [S/n]: "
    read user_choice
    if [ $user_choice = 'N' -o $user_choice = 'n' ]; then
        echo "O script configura o VIM a partir de um modelo pré-existente, por isso é preciso excluir o arquivo anterior."
        exit 0
    elif [ $user_choice = 'S' -o $user_choice = 's' ]; then
        echo " Excluindo o arquivo .vimrc..."
        rm -f /home/$username/.vimrc
    else
        echo "Opção desconhecida!"
        exit 0
    fi
else
    echo "O arquivo não existe ou está vazio!"
    if [ -e pre-config.txt -a -s pre-config.txt ]; then
        echo "Copiando o arquivo de configuração..."
        cp pre-config.txt /home/$username/.vimrc
    else
        echo "Houve um erro ao procurar pelo arquivo .vimrc."
        echo "Arquivo não encontrado ou vazio."
        echo "Verifique se o arquivo .vimrc existe no mesmo diretório do script executado e se contém as configuração necessário e tente novemente."
        exit 0
    fi
fi

echo "Copiando as cofiguração do gerenciador de plugins para o diretório /home/$username/.vim/autoload/"
curl -LSso /home/$username/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

echo "Instalando os plugins..."
git clone https://github.com/scrooloose/nerdtree /home/$username/.vim/bundle/nerdtree
git clone https://github.com/vim-airline/vim-airline /home/$username/.vim/bundle/airline
git clone https://github.com/vim-airline/vim-airline-themes /home/$username/.vim/bundle/airline-themes
git clone https://github.com/sheerun/vim-polyglot /home/$username/.vim/bundle/polyglot
git clone https://github.com/voldikss/vim-floaterm /home/$username/.vim/bundle/floaterm

# Mudando o usuário e grupo dos diretórios criados
# Os diretórios são criados como root porque o script é executando com sudo
chown -R $username:$username /home/$username/.vim
chown $username:$username /home/$username/.vimrc

echo "Os seguintes plugins foram instalados"
echo "nerdtree"
echo "airline"
echo "airline-themes"
echo "polyglot"
echo "floaterm"

echo "A configuração está finalizada!"

exit 0
