---
marp: true
paginate: true
class:
    - lead
    - invert
header: UFSJ | Secomp 2025
footer: Minicurso Docker
style: |
  @font-face {
    font-family: 'Big Noodle Too Oblique';
    src: url('font/bignoodletoooblique.ttf') format('truetype');
    font-weight: normal;
    font-style: normal;
  }

  h1, h2, h3, h4, h5 {
    border-bottom: none !important;
  }

  .columns {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 1rem;
  }

  .three-columns {
    display: grid;
    grid-template-columns: 33% 33% 33%;
    gap: 1rem;
  }

  .centered {
    text-align: center;
  }

  .unequal-columns {
    display: grid;
    grid-template-columns: auto auto auto;
    gap: 1rem;
  }

  .column-23 {
    grid-column: 1 / 3;
  }

  .column-13 {
    grid-column: 3 / 3;
  }

  .column-34 {
    grid-column: 1 / 4;
  }

  .column-14 {
    grid-column: 4 / 4;
  }

  section.title h1 {
    font-size: 120px;
    line-height: 120px;
    font-family: 'Big Noodle Too Oblique';
    color: white;
    background-color: #1E63EE;
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
  }

  section.small h1 {
    font-size: 80px;
    line-height: 80px;
  }

  section.attention h1 {
    background-color: #EE1E63 !important;
  }

  .warning {
    background-color: red;
  }

  blockquote {
    border: none !important;
    border-left: none !important;
  }
---

<!-- _header: '' -->
<!-- _footer: '' -->
<!-- _paginate: false -->

# Docker - Usando contêineres para criar ambientes reproduzíveis
## SECOMP 2025
### Brenno Lemos

- ![width:30px](./img/github-logo.png) [Syndelis](https://github.com/Syndelis)
- ![width:30px](./img/mastodon-logo.svg) [@brenno@fosstodon.org](https://fosstodon.org/@brenno)

![bg right vertical 50%](./img/secomp-2025.png)
![bg right vertical 30%](./img/ufsj.png)

---

### 0. Sobre mim

<div class="warning">TODO: Write this down</div>

--- 

# Antes de começarmos

## Cheque se sua máquina está com Docker instalado e com as permissões corretas

```sh
$ docker run --rm hello-world
```

![bg left:35%](./img/docker.jpg)

---

<div class="centered">

# Aprenda a user Docker!

</div>

<div class="three-columns">

<div class="centered">

[secomp2025.brenno.codes](https://secomp2025.brenno.codes)

![w:280px](./img/qrcode-slides.png)

</div>

<div class="centered">

[Repositório dos slides](https://github.com/Syndelis/minicurso-docker-secomp-2025)

![w:280px](./img/qrcode-git.png)

</div>

<div class="centered">

[Documentação Docker](https://docs.docker.com/)

![w:280px](./img/qrcode-docker-docs.png)

</div>


</div>


---

<!-- Perguntar se os alunos estão familiares com o conceito de máquinas virtuais -->
<!-- Senão, fazer um paralelo com emuladores -->

<!-- _class: title -->
<!-- _header: '' -->

# 1. O que é Docker?

Docker é uma coleção de ferramentas de virtualização. Pode ser comparado com máquinas virtuais, porém possui uma abordagem programática.

Isto quer dizer que o Docker é ideal para a criação de ambientes reproduzíveis, isto é, ambientes que possa ser criado uma vez e executado inúmeras vezes em diferentes máquinas, sempre gerando o mesmo resultado.

---

# 1.1. Pra quê serve o Docker?

Docker possui inúmeras aplicações. Aqui estão algumas que abordaremos neste minicurso:

- Rodar programas sem a necessidade de instalá-los na máquina;
- Compilar programas para outros sistemas operacionais;
- Executar serviços como webservers e bancos de dados;
- Rodar _pipelines_ em ambientes externos como [GitHub Actions](https://docs.github.com/en/actions);

---

<!-- _class: title small -->
<!-- _header: '' -->
<!-- _footer: 'Todos os comandos usados durante este minicurso estão disponíveis no [repositório](https://github.com/Syndelis/minicurso-docker-secomp-2025)' -->

# 2. Rodando programas sem instalá-los

Neste exemplo, executaremos a aplicação [Copyparty](https://github.com/9001/copyparty/) usando Docker, sem a necessidade de instalar o programa ou suas dependências.

<div class="columns">

<div>

```sh
docker run --rm -it \
 -u 1000 -p 3923:3923 \
 -v .:/w copyparty/min -v .::rw:a
```

Rode este comando e acesse o serviço pelo navegador:

http://localhost:3923

</div>


<div>

![w:560px](./img/copyparty.png)

</div>

</div>

---

# 2.1. Usando qualquer versão de Python

Muitos programas famosos estão disponíveis em formas de imagens no [Docker Hub](https://hub.docker.com).

Por exemplo, é possível usar a versão mais recente de Python para rodar um script:

```sh
docker run --rm -v ./:/tmp python:3.13 python3 /tmp/hello_world.py
```

Isto pode ser útil quando a versão desejada do interpretador não estiver disponível na máquina. Por exemplo, Ubuntu 22.04 e derivados possuem Python 3.10 instalado, mas a versão 3.13 já foi lançada.

<!-- De forma similar, estes slides são "compilados" em HTML por meio de ferramenta de JavaScript que eu propositalmente não instalei no meu computador. Ao invés, eu usei um contêiner com a ferramenta pré-instalada. -->

<!-- Exercitar a execução de contêiner Python interativo para facilitar a transição para o próximo slide -->

---

# 2.1.1. E as dependências?

Poderíamos escrever um shell script para instalar uma biblioteca e depois executar o nosso script.

<div class="columns">

<div>

`mult_array.sh`
```sh
#!/usr/bin/env bash
pip3 install numpy
python3 mult_array.py
```

</div>


<div>

`mult_array.py`
```py
import numpy as np
x = np.array([1, 2, 3, 4])
print(x * 3)
```

</div>
</div>

```sh
docker run --rm -v ./:/tmp -w /tmp python:3.13 bash mult_array.sh
```

Contudo, há um problema: sempre que executamos o contêiner, a dependência tem que ser baixada novamente. Veremos no próximo capítulo como podemos construir novas imagens de Docker para evitar isso.

---

<!-- _class: title small -->
<!-- _header: '' -->

# 3. Compilando programas para outro 'OS'

É possível usar o Docker para compilar programas para outros sistemas operacionais. Por exemplo, seria possível rodar Docker no Windows ou MacOS (_internamente gerenciado por VMs_) e compilar programas para Linux.

Neste exemplo, escreveremos uma nova imagem de Docker que compila um programa em C e o executa.

---

<!-- _header: '' -->
<!-- _footer: 'As explicações neste slide estão dramaticamente simplificadas para efeitos didáticos. ' -->
<!-- _class: attention title small -->

# 3.1. Intermissão: O que é uma imagem de Docker?

De forma simplificada, todo comando executado com Docker está dentro de um contêiner. Todo contêiner é baseado em uma imagem, e toda imagem possui múltiplas camadas. _Nada se cria, tudo se copia_.

<div class="columns">

<div>

Cada camada pode modificar o sistema de arquivos. Por exemplo, se a camada base for uma distribuição Linux como o [Debian](https://www.debian.org/), uma possível próxima camada poderia instalar um programa, como o [Emacs](https://www.gnu.org/software/emacs/) o GCC, ou o Python.

</div>

<div>

![h:300px](./img/docker-layers.png)

</div>
</div>

---

# 3.2. Criando sua primeira imagem

```docker
FROM debian                                  # <-- Camada base
RUN apt-get update && apt-get install -y gcc # <-- Instale GCC
COPY main.c main.c                           # <-- Copie o programa do computador para o contêiner
RUN gcc main.c -o main                       # <-- Compile o programa
ENTRYPOINT ["./main"]                        # <-- Rode o programa
```

```sh
$ docker build -t minha_imagem -f Dockerfile .

$ docker run minha_imagem
```

---

## 3.3. Reparação histórica: criando nossa imagem de Python
