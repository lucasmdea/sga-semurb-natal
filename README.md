# Instalação do NOVO SGA v1.5

Tutorial de instalação do Novo SGA, na Secretaria Municipal de Meio Ambiente e Urbanismo de Natal (SEMURB)

Execute ou siga o passo a passo do install-sga.sh

## Tela de seleção inicial

Painel de Atendimento, altere o index.php no diretorio /var/www/html, pelo arquivo index.php anexado

Baixe o arquivo painel.zip, com o painel atualizado

## Instando o Banco de Dados no NOVO SGA

utilize o comando ip address para identificar o ip do seu servidor e o digite em um navegador, ou se preferir utilize o ip 127.0.0.1

## Alterações no Banco de Dados
```mysql
ALTER TABLE atendimentos CHANGE sigla_senha sigla_senha VARCHAR(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;

ALTER TABLE painel_senha CHANGE sig_senha sig_senha VARCHAR(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;

ALTER TABLE uni_serv CHANGE sigla sigla VARCHAR(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;

ALTER TABLE historico_atendimentos CHANGE sigla_senha sigla_senha VARCHAR(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
```
## Alterações nos arquivos


sudo nano -l /var/www/html/novosga/src/Novosga/Model/Util/Senha.php

```nano
/**
 * Define a sigla da senha.
 *
 * @param char $sigla
 */
public function setSigla($sigla)
{
    if (is_string($sigla) && (strlen($sigla) == 1 || strlen($sigla) == 2 || strlen($sigla) == 3 || strlen($sigla) == 4)) {
        $this->sigla = $sigla;
    } else {
        throw new \Exception(_('A sigla da senha deve ser um char'));
    }
}
```
```terminal
sudo nano -l /var/www/html/novosga/modules/sga/unidade/views/index.html.twig
```
Linha 42 e 43

size="3"
maxlength="4"

```terminal
sudo nano -l /var/www/html/novosga/modules/sga/unidade/public/css/style.cs
```
Linha 9

#servicos td.sigla {
width: 90px;
}
```terminal
sudo sed -i '215s|5|6|i' /var/www/html/novosga/modules/sga/triagem/views/index.html.twig
sudo sed -i '302s|5|6|i' /var/www/html/novosga/modules/sga/atendimento/views/index.html.twig
sudo sed -i '33s|5|6|i' /var/www/html/novosga/modules/sga/monitor/views/index.html.twig
```
Limpar o cache
```termianal
sudo rm -r /var/www/html/novosga/var/cache/*
```
# Instalação da impressora termica

extraia o arquivo driver-elgin-i7-i8-e-i9-windows-e-linux.zip
