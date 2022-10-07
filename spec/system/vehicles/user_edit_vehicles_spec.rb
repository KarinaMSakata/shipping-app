require 'rails_helper'

describe 'Usuário edita um veículo' do 
  it 'e deve estar autenticado como admin' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    vehicle = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Doblo', identification:'ABC1D23', year_manufacture:'2019', max_load: 150)

    #Act
    login_as(user)
    visit root_url
    click_on 'Frota'
    click_on 'Veículos Cadastrados'
    click_on 'Carro Fiat | Doblo'

    #Assert
    expect(page).not_to have_link 'Editar'
  end

  it 'com sucesso' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    vehicle = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Doblo', identification:'ABC1D23', year_manufacture:'2019', max_load: 150)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Frota'
    click_on 'Veículos Cadastrados'
    click_on 'Carro Fiat | Doblo'
    click_on 'Editar'
    fill_in 'Tipo', with: 'Minivan'
    fill_in 'Ano de fabricação', with: '2018'
    fill_in 'Capacidade máxima de carga (peso)', with: 200
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Veículo editado com sucesso!'
    expect(page).to have_content 'Tipo: Minivan'
    expect(page).to have_content 'Ano de fabricação: 2018'
    expect(page).to have_content 'Capacidade máxima de carga (peso): 200'
  end

  it 'e dados permanecem obrigatórios' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    vehicle = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Doblo', identification:'ABC1D23', year_manufacture:'2019', max_load: 150)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Frota'
    click_on 'Veículos Cadastrados'
    click_on 'Carro Fiat | Doblo'
    click_on 'Editar'
    fill_in 'Tipo', with: ''
    fill_in 'Ano de fabricação', with: ''
    fill_in 'Capacidade máxima de carga (peso)', with: nil
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Não foi possível atualizar o veículo.'
  end

  it 'e altera status do veículo' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    vehicle = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Doblo', identification:'ABC1D23', year_manufacture:'2019', max_load: 150)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Frota'
    click_on 'Veículos Cadastrados'
    click_on 'Carro Fiat | Doblo'
    click_on 'Em operação'

    #Assert
    expect(page).not_to have_content 'Status: Em manutenção'
    expect(page).to have_content 'Status: Em operação'
  end
end