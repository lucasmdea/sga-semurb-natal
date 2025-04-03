# Instalação do NOVO SGA v1.5

Tutorial de instalação do Novo SGA, na Secretaria Municipal de Meio Ambiente e Urbanismo de Natal (SEMURB)

Execute ou siga o passo a passo do install-sga.sh

# Tela de seleção inicial

Painel de Atendimento, altere o index.php no diretorio /var/www/html, pelo arquivo anexado

Baixe o arquivo painel.zip, com o painel atualizado

# Alterações no Banco de Dados

ALTER TABLE atemdimentos MODIFY COLUMN sigla_senha VARCHAR(4) NOT NULL;
ALTER TABLE historico_atendimentos MODIFY COLUMN sigla_senha VARCHAR(4) NOT NULL;
ALTER TABLE painel_senha MODIFY COLUMN sig_senha VARCHAR(4) NOT NULL;
ALTER TABLE uni_serv MODIFY COLUMN sigla VARCHAR(4) NOT NULL;
ALTER TABLE view_historico_atendimentos MODIFY COLUMN sigla_senha VARCHAR(4) NOT NULL;

# Alterações nos arquivos

sudo nano -l /var/www/html/novosga/src/Novosga/Model/Util/Senha.php

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

sudo nano -l /var/www/html/novosga/modules/sga/unidade/views/index.html.twig

Linha 42 e 43

size="3"
maxlength="4"

sudo nano -l /var/www/html/novosga/modules/sga/unidade/public/css/style.cs

Linha 9

#servicos td.sigla {
width: 90px;
}

sudo sed -i '215s|5|6|i' /var/www/html/novosga/modules/sga/triagem/views/index.html.twig
sudo sed -i '302s|5|6|i' /var/www/html/novosga/modules/sga/atendimento/views/index.html.twig
sudo sed -i '33s|5|6|i' /var/www/html/novosga/modules/sga/monitor/views/index.html.twig

Limpar o cache
rm -r /var/www/html/novosga/var/cache/*

# Instalação da impressora termica

extraia o arquivo driver-elgin-i7-i8-e-i9-windows-e-linux.zip
