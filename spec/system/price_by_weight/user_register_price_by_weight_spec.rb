require 'rails_helper'
describe 'Usuário cadastra nova configuração de preço por peso' do
  it 'a partir do menu' do
    #Arrage
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Cadastrar Preço por Peso'

    #Assert
    expect(page).to have_field 'Peso mínimo(kg)'
    expect(page).to have_field 'Peso máximo(kg)'
    expect(page).to have_field 'Valor/Km'
  end

  it 'e deve estar autenticado como admin' do
    #Arrage
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)

    #Act
    login_as(user)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Cadastrar Preço por Peso'

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
    click_on 'Cadastrar Preço por Peso'
    fill_in 'Peso mínimo(kg)', with: 1
    fill_in 'Peso máximo(kg)', with: 10
    fill_in 'Valor/Km', with: 0.50
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Configuração de preço cadastrada com sucesso!'
    expect(page).to have_content 'Peso mínimo(kg): 1kg'
    expect(page).to have_content 'Peso máximo(kg): 10kg'
    expect(page).to have_content 'Valor/Km: R$ 0,50'
  end

  it 'e dados são obrigatórios' do
    #Arrage
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Cadastrar Preço por Peso'
    fill_in 'Peso mínimo(kg)', with: nil
    fill_in 'Peso máximo(kg)', with: nil
    fill_in 'Valor/Km', with: nil
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Não foi possível cadastrar esta configuração de preço.'
  end 
end