---
marp: true
paginate: true
class:
    - lead
    - invert
header: UFSJ | Secomp 2025
footer: Minicurso Docker
style: |
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

TODO

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

["Documentação"](https://doc.rust-lang.org/book/)

![w:280px](./img/qr-the-book.svg)

</div>

<div class="centered">

[secomp2025.brenno.codes](https://secomp2025.brenno.codes)

![w:280px](./img/qrcode-slides.png)

</div>


</div>


---

<!-- Perguntar se os alunos estão familiares com o conceito de máquinas virtuais -->
<!-- Senão, fazer um paralelo com emuladores -->

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

# 2. Rodando programas sem instalá-los


