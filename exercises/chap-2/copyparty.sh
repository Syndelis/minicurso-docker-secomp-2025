#!/usr/bin/env bash

script_location=$(dirname $(readlink -fn "$0"))
repo_root=$(dirname $(dirname $script_location))

docker run --rm -it -u 1000 -p 3923:3923 -v $repo_root:/w copyparty/min -v .::rw:a
# Agora acesse esta porta no seu navegador: http://localhost:3923

# Explicação do comando:
# docker  # <- Esse é o comando base, o docker
#   run  # <- subcomando 'run': executa o comando base de uma imagem
#   --rm  # <- remove (destrói completamente) o contêiner depois que o pararmos
#   -it  # <- modo interativo
#   -u $(id -u)  # <- rode o comando como o usuário atual, ao invés de root
#   -p 3923:3923  # <- exponha o port 3923 do contêiner
#   -v $repo_root:/w  # <- (volume) monte a pasta base desse repositório no caminho "/w" do contêiner (isso é bem específico a imagem que estamos usando)
#   copyparty/min  # <- o nome da imagem. Veja mais detalhes sobre ela em https://hub.docker.com/r/copyparty/min
#   -v .::rw:a # <- argumentos para o comando sendo executado. Não tem a ver com o docker, apesar desse '-v' parecer a flag de volume acima

