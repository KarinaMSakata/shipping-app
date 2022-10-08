require 'rails_helper'
describe 'Usuário cadastra nova configuração de prazo por distância' do
  it 'a partir do menu' do
    #Arrage
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Cadastrar Prazo de Entrega'

    #Assert
    expect(page).to have_field 'Origem(km)'
    expect(page).to have_field 'Destino(km)'
    expect(page).to have_field 'Horas'
  end

  it 'e deve estar autenticado como admin' do
    #Arrage
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)

    #Act
    login_as(user)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Cadastrar Prazo de Entrega'

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
    click_on 'Cadastrar Prazo de Entrega'
    fill_in 'Origem(km)', with: 1
    fill_in 'Destino(km)', with: 100
    fill_in 'Horas', with: 48
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Prazo de Entrega cadastrado com sucesso!'
    expect(page).to have_content 'Origem(km): 1km'
    expect(page).to have_content 'Destino(km): 100km'
    expect(page).to have_content 'Horas: 48 horas'
  end

  it 'e dados são obrigatórios' do
    #Arrage
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Cadastrar Prazo de Entrega'
    fill_in 'Origem(km)', with: nil
    fill_in 'Destino(km)', with: nil
    fill_in 'Horas', with: nil
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Não foi possível cadastrar esta configuração de preço.'
    expect(page).to have_content 'Origem(km) não pode ficar em branco'
  end
end