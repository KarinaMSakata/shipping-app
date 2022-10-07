require 'rails_helper'
describe 'Usuário cadastra um veículo' do
  it 'e deve estar autenticado como admin' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role:'user')

    #Act
    login_as(user)
    visit root_url
    click_on 'Frota'
    click_on 'Cadastrar Veículo'

    #Assert
    expect(page).to have_content 'Você não possui permissão para acessar esta página!'
  end

  it 'a partir de uma opção no menu' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role:'admin')

    #Act
    login_as(admin)
    visit root_url
    click_on 'Frota'
    click_on 'Cadastrar Veículo'

    #Assert
    expect(page).to have_field 'Tipo'
    expect(page).to have_field 'Marca'
    expect(page).to have_field 'Modelo'
    expect(page).to have_field 'Placa de identificação'
    expect(page).to have_field 'Ano de fabricação'
    expect(page).to have_field 'Capacidade máxima de carga (peso)'
  end

  it 'com sucesso' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role:'admin')

    #Act
    login_as(admin)
    visit root_url
    click_on 'Frota'
    click_on 'Cadastrar Veículo'
    fill_in 'Tipo', with: 'Carro'
    fill_in 'Marca', with: 'Fiat'
    fill_in 'Modelo', with: 'Doblo'
    fill_in 'Placa de identificação', with: 'ABC1D23'
    fill_in 'Ano de fabricação', with: '2019'
    fill_in 'Capacidade máxima de carga (peso)', with: 150
    click_on 'Gravar'
    
    #Assert
    expect(page).to have_content 'Veículo cadastrado com sucesso.'
    expect(page).to have_content 'Tipo: Carro'
    expect(page).to have_content 'Marca: Fiat'
    expect(page).to have_content 'Modelo: Doblo'
    expect(page).to have_content 'Placa de identificação: ABC1D23'
    expect(page).to have_content 'Ano de fabricação: 2019'
    expect(page).to have_content 'Capacidade máxima de carga (peso): 150kg'
    expect(page).to have_content 'Status: Em manutenção'

  end

  it 'e dados são obrigatórios' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role:'admin')

    #Act
    login_as(admin)
    visit root_url
    click_on 'Frota'
    click_on 'Cadastrar Veículo'
    fill_in 'Tipo', with: ''
    fill_in 'Marca', with: ''
    fill_in 'Modelo', with: ''
    fill_in 'Placa de identificação', with: ''
    fill_in 'Ano de fabricação', with: ''
    fill_in 'Capacidade máxima de carga (peso)', with: nil
    click_on 'Gravar'
    
    #Assert
    expect(page).to have_content 'Não foi possível cadastrar o veículo.'
    expect(page).to have_content 'Tipo não pode ficar em branco'
  end
end