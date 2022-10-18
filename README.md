SGFE - Sistema Gerencial de Frete para E-commerce
Desenvolvido por Karina Midori Sakata

Aplicação para um e-commerce, com a finalidade de gerenciar o envio de recebimento de encomendas em escala nacional.

Desenvolvido em Ruby on Rails
  Versão ruby 3.0.0
  Versão rails 7.0.4
  Banco de Dados SQLite3

Gems instaladas para execução de testes:
  gem "rspec-rails" 
  gem "capybara" 

Gem instalada para criação de autenticação:
  gem "devise"

Gem instalada para bootstrap
gem 'bootstrap', '~> 5.2.1'

Links úteis:
  Organização de projeto: https://github.com/users/KarinaMSakata/projects/1

Instruções para execução de testes:
  No terminal, acesse o diretório do projeto e execute o comando "rspec". Em caso de falha, o erro será apresentado na tela com uma mensagem vermelha. Caso não haja nenhum erro a ser corrigido, será devolvida a quantidade de testes na cor verde.

Instruções para execução do projeto:
  No terminal, execute o comando rails db:seed e em seguida rails server.
  Para realizar o login como Administrador, use as seguintes credenciais: email = anamaria@sistemadefrete.com.br | senha = password
  Para realizar o login como Usuário Regular, use as seguintes credenciais: email = carlos@sistemadefrete.com.br | senha = password

OBSERVAÇÕES 
  Alguns detalhes que ainda não puderam ser corrigidos:
   [] checar porque alguns horários não estão retornando
   [] checar porque no momento da seleção do veículo, para a ordem de serviço, outro veículo é retornado
   [] validações adicionais
   [] há alguns objetos criados no seed, apenas com a finalidade de testar o atraso no prazo de entrega
