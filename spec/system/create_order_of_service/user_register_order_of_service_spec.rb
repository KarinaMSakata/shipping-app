require 'rails_helper'
describe 'Usuário cadastra nova ordem de serviço' do
  it 'a partir do menu' do
    #Arrage
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Ordem de Serviço'
    click_on 'Cadastrar Ordem de Serviço'

    #Assert
    expect(page).to have_content 'Cadastrar Ordem de Serviço'
    expect(page).to have_content 'Dados para retirada do produto'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'Código do produto'
    expect(page).to have_content 'Dimensões do produto'
    expect(page).to have_field 'Altura(cm)'
    expect(page).to have_field 'Largura(cm)'
    expect(page).to have_field 'Profundidade(cm)'
    expect(page).to have_field 'Peso(Kg)'
    expect(page).to have_content 'Dados para entrega'
    expect(page).to have_field 'Endereço de entrega'
    expect(page).to have_field 'Cidade de entrega'
    expect(page).to have_field 'Estado de entrega' 
    expect(page).to have_field 'Destinatário'
    expect(page).to have_field 'CPF'
    expect(page).to have_field 'Data de nascimento'
    expect(page).to have_content 'Deslocamento a ser percorrido'
    expect(page).to have_field 'Distância total(Km)'
  end

  it 'e deve estar autenticado como admin' do
    #Arrage
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)

    #Act
    login_as(user)
    visit root_url
    click_on 'Ordem de Serviço'
    click_on 'Cadastrar Ordem de Serviço'

    #Assert
    expect(page).to have_content 'Você não possui permissão para acessar esta página!'
  end

  it 'com sucesso' do
    #Arrage
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    
    allow(SecureRandom).to receive(:alphanumeric).and_return 'ABCDEFGHI123456'
    #Act
    login_as(admin)
    visit root_url
    click_on 'Ordem de Serviço'
    click_on 'Cadastrar Ordem de Serviço'
    fill_in 'Endereço', with: 'Av. das Pitangueiras, 100'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'Código do produto', with: 'LG-LCD-49-5502-P'
    fill_in 'Altura(cm)', with: '50'
    fill_in 'Largura(cm)', with: '90'
    fill_in 'Profundidade(cm)', with: '5'
    fill_in 'Peso(Kg)', with: '14'
    fill_in 'Endereço de entrega', with: 'Rua das Flores, 20'
    fill_in 'Cidade de entrega', with: 'Osasco'
    fill_in 'Estado de entrega', with: 'SP'
    fill_in 'Destinatário', with: 'João de Almeida Santos'
    fill_in 'CPF', with: '37688849020'
    fill_in 'Data de nascimento', with: '23/01/1990'
    fill_in 'Distância total(Km)', with: 41
    click_on 'Gravar'
      
    #Assert
    expect(page).to have_content 'Ordem de Serviço cadastrada com sucesso.'
    expect(page).to have_content 'Status: pendente'
    expect(page).to have_content 'Código de rastreio: ABCDEFGHI123456'
    expect(page).to have_content 'Dados para retirada do produto'
    expect(page).to have_content 'Endereço: Av. das Pitangueiras, 100'
    expect(page).to have_content 'Cidade: São Paulo'
    expect(page).to have_content 'Estado: SP'
    expect(page).to have_content 'Código do produto: LG-LCD-49-5502-P'
    expect(page).to have_content 'Dimensões do produto'
    expect(page).to have_content 'Altura(cm): 50cm'
    expect(page).to have_content 'Largura(cm): 90cm'
    expect(page).to have_content 'Profundidade(cm): 5cm'
    expect(page).to have_content 'Peso(Kg): 14kg'
    expect(page).to have_content 'Dados para entrega do produto'
    expect(page).to have_content 'Endereço de entrega: Rua das Flores, 20'
    expect(page).to have_content 'Cidade de entrega: Osasco'
    expect(page).to have_content 'Estado de entrega: SP'
    expect(page).to have_content 'Destinatário: João de Almeida Santos'
    expect(page).to have_content 'CPF: 376.888.490-20'
    expect(page).to have_content 'Data de nascimento: 23/01/1990'
    expect(page).to have_content 'Deslocamento a ser percorrido'
    expect(page).to have_content 'Distância total(Km): 41km'
  end

  it 'e dados são obrigatórios' do
    #Arrage
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Ordem de Serviço'
    click_on 'Cadastrar Ordem de Serviço'
    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'Código do produto', with: ''
    fill_in 'Altura(cm)', with: ''
    fill_in 'Largura(cm)', with: ''
    fill_in 'Profundidade(cm)', with: ''
    fill_in 'Peso(Kg)', with: ''
    fill_in 'Endereço de entrega', with: ''
    fill_in 'Cidade de entrega', with: ''
    fill_in 'Estado de entrega', with: ''
    fill_in 'Destinatário', with: ''
    fill_in 'CPF', with: ''
    fill_in 'Data de nascimento', with: ''
    fill_in 'Distância total(Km)', with: ''
    click_on 'Gravar'
      
    #Assert
    expect(page).to have_content 'Não foi possível cadastrar esta ordem de serviço'
    expect(page).to have_content 'Endereço não pode ficar em branco'
 
  end
end