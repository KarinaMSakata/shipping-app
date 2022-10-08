require 'rails_helper'
describe 'Usuário cadastra nova configuração de preço por distância' do
  it 'a partir do menu' do
    #Arrage
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Cadastrar Preço por Distância'

    #Assert
    expect(page).to have_field 'Distância mínima(km)'
    expect(page).to have_field 'Distância máxima(km)'
    expect(page).to have_field 'Valor'
  end

  it 'e deve estar autenticado como admin' do
    #Arrage
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)

    #Act
    login_as(user)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Cadastrar Preço por Distância'

    #Assert
    expect(page).to have_content 'Você não possui permissão para acessar esta página!'
  end

  it 'com sucesso' do
    #Arrage
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Cadastrar Preço por Distância'
    fill_in 'Distância mínima(km)', with: 1
    fill_in 'Distância máxima(km)', with: 50
    fill_in 'Valor', with: 9.00
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Configuração de preço cadastrada com sucesso!'
    expect(page).to have_content 'Distância mínima(km): 1km'
    expect(page).to have_content 'Distância máxima(km): 50km'
    expect(page).to have_content 'Valor: R$ 9,00'
  end

  it 'e dados são obrigatórios' do
    #Arrage
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Cadastrar Preço por Distância'
    fill_in 'Distância mínima(km)', with: nil
    fill_in 'Distância máxima(km)', with: nil
    fill_in 'Valor', with: nil
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Não foi possível cadastrar esta configuração de preço.'
    expect(page).to have_content 'Distância mínima(km) não pode ficar em branco'
  end
end