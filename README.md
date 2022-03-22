# vim_config

Simples script para configuração automática do VIM com alguns plugins e itens que eu considero importante e útil.

## Pontos a serem considerados

1. Executa apenas em red hat que tenha como gestor de pacotes o dnf, porém pode ser facilmente substituido por yum ou apt-get no próprio script. Sobre esse ponto, na próxima atualização resolverei isso.

2. Instala apenas os plugins que estão listados no próprio script. Este é outro ponto de melhora futura.

3. Deve ser executado como sudo. É recomendado que o script seja alterado para execução antes de executar de fato com chmod +x vim_config.sh.

4. O script não se aplica ao usuário root por este ter um diretório home em local diferente. Isto é algo que também pode ser facilmente modificado mas é bem pouco recomendado.
