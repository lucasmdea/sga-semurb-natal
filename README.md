# Instalação do NOVO SGA v1.5

Esse documento tem como objetivo explicar o passo a passo da instalação do Novo SGA, na Secretaria Municipal de Meio Ambiente e Urbanismo de Natal (SEMURB)

Execute ou siga o passo a passo do install-sga.sh

## Tela de seleção inicial

Painel de Atendimento, altere o index.php no diretorio /var/www/html, pelo arquivo index.php anexado

Baixe o arquivo painel.zip, com o painel atualizado

## Instando o Banco de Dados no NOVO SGA

utilize o comando ip address para identificar o ip do seu servidor e o digite em um navegador, ou se preferir utilize o ip 127.0.0.1

### Alterações no Banco de Dados

Foi necessário fazer uma adaptação em algumas tabelas do banco de dados para existir 3 Caracteres de cada tipo "Serviço"

```mysql
ALTER TABLE atendimentos CHANGE sigla_senha sigla_senha VARCHAR(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;

ALTER TABLE painel_senha CHANGE sig_senha sig_senha VARCHAR(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;

ALTER TABLE uni_serv CHANGE sigla sigla VARCHAR(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;

ALTER TABLE historico_atendimentos CHANGE sigla_senha sigla_senha VARCHAR(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
```
### Alterações nos arquivos

O mesmo motivo de alteração do banco de dados deve ser seguido na string do PHP
Execute o comando a seguir:
```terminal
sudo nano -l /var/www/html/novosga/src/Novosga/Model/Util/Senha.php
```
Altere a linha 34
```nano
    if (is_string($sigla) && (strlen($sigla) == 1 || strlen($sigla) == 2 || strlen($sigla) == 3 || strlen($sigla) == 4)) {
```

Faça também uma alteração na página index.html.twig
Execute o comando a seguir:
```terminal
sudo nano -l /var/www/html/novosga/modules/sga/unidade/views/index.html.twig
```
Altere as linhas 42 e 43
```nano
size="3"
maxlength="4"
```
Altere o arquivo .css para aumentar os pixels da sigla dos "Serviços" na página de "Configuração" do Serviço Web
```terminal
sudo nano -l /var/www/html/novosga/modules/sga/unidade/public/css/style.css
```
Altere a linha 9
```nano
#servicos td.sigla {
width: 90px;
}
```
Para finalizar as alterações nos arquivos views do Serviço Web
```terminal
sudo sed -i '215s|5|6|i' /var/www/html/novosga/modules/sga/triagem/views/index.html.twig
sudo sed -i '302s|5|6|i' /var/www/html/novosga/modules/sga/atendimento/views/index.html.twig
sudo sed -i '33s|5|6|i' /var/www/html/novosga/modules/sga/monitor/views/index.html.twig
```

## Limpeza do cache
Faça uma limpeza no cache do sistema

```terminal
sudo rm -r /var/www/html/novosga/var/cache/*
```

# Bonus: Instalação da impressora termica

Durante a instalação deste sistema, a SEMURB utilizava uma impressora termica para imprimir as fichas.
Caso seja necessário a utilização da mesma, extraia o arquivo driver-elgin-i7-i8-e-i9-windows-e-linux.zip, e siga o passo a passo existente dentro desse .zip para realizar a instalação corretamente.
