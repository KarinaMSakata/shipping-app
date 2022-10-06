require 'rails_helper'

describe 'Usuário admin cadastra um modelo de transporte' do
  it 'se estiver autenticado' do 
    #Arrange
    #Act
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Cadastrar Nova Modalidade'

    #Assert
    expect(current_url).to eq new_user_session_url
  end

  it 'a partir de uma opção no menu' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role:'admin')

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Cadastrar Nova Modalidade'

    #Assert
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Distância Mínima Praticada'
    expect(page).to have_field 'Distância Máxima Praticada'
    expect(page).to have_field 'Peso Mínimo'
    expect(page).to have_field 'Peso Máximo'
    expect(page).to have_field 'Taxa Fixa'
  end

  it 'com sucesso' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role:'admin')

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Cadastrar Nova Modalidade'
    fill_in 'Nome', with: 'Moto'
    fill_in 'Distância Mínima Praticada', with: 1
    fill_in 'Distância Máxima Praticada', with: 80
    fill_in 'Peso Mínimo', with: 0.50
    fill_in 'Peso Máximo', with: 30
    fill_in 'Taxa Fixa', with: 5
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Modalidade de Transporte cadastrada com sucesso.'
    expect(page).to have_content 'MOTO'
    expect(page).to have_content 'Distância Mínima Praticada: 1km'
    expect(page).to have_content 'Distância Máxima Praticada: 80km'
    expect(page).to have_content 'Peso Mínimo: 0kg'
    expect(page).to have_content 'Peso Máximo: 30kg'
    expect(page).to have_content 'Taxa Fixa: R$ 5,00'
  end

  it 'e dados são obrigatórios' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role:'admin')
    
    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Cadastrar Nova Modalidade'
    fill_in 'Nome', with: ''
    fill_in 'Distância Mínima Praticada', with: nil
    fill_in 'Distância Máxima Praticada', with: nil
    fill_in 'Peso Mínimo', with: nil
    fill_in 'Peso Máximo', with: nil
    fill_in 'Taxa Fixa', with: nil
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Não foi possível realizar o seu cadastro.'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Distância Mínima Praticada não pode ficar em branco' 
    expect(page).to have_content 'Distância Máxima Praticada não pode ficar em branco'
    expect(page).to have_content 'Peso Mínimo não pode ficar em branco'
    expect(page).to have_content 'Peso Máximo não pode ficar em branco'
    expect(page).to have_content 'Taxa Fixa não pode ficar em branco'
  end

  it 'mas está autenticado como regular' do
   #Arrange
   user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role:'user')

   #Act
   login_as(user)
   visit root_url
   click_on 'Modalidade de Transporte'
   click_on 'Cadastrar Nova Modalidade'

   #Assert
   expect(page).to have_content 'Você não possui permissão para acessar esta página!'
  end

end