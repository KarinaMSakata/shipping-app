require 'rails_helper'

describe 'Usuário busca por um veículo' do 
  it 'a partir da listagem de veículos' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)

    #Act
    login_as(user)
    visit root_url
    click_on 'Frota'
    click_on 'Veículos Cadastrados'

    #Assert
    expect(page).to have_field 'Buscar Veículo'
    expect(page).to have_button 'Buscar'
  end

  it 'e deve estar autenticado' do
    #Arrange
    #Act
    visit root_url
    click_on 'Frota'
    click_on 'Veículos Cadastrados'

    #Assert
    expect(page).not_to have_field 'Buscar Veículo'
    expect(page).not_to have_button 'Buscar'  
  end

  it 'e encontra veículo através da placa' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    vehicle = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Doblo', identification:'ABC1D23', year_manufacture:'2019', max_load: 150)
    other_vehicle = Vehicle.create!(sort: 'Carro', brand: 'Chevrolet', model: 'Meriva', identification:'CDF4G56', year_manufacture:'2019', max_load: 150)
  
    #Act
    login_as(user)
    visit root_url
    click_on 'Frota'
    click_on 'Veículos Cadastrados'
    fill_in 'Buscar Veículo', with: 'ABC'
    click_on 'Buscar'

    #Assert
    expect(page).to have_content 'Resultados da Busca por: ABC'
    expect(page).to have_content '1 veículo encontrado'
    expect(page).to have_content 'Placa de Identificação: ABC1D23'
    expect(page).to have_content 'Veículo: Carro Fiat | Doblo'
    expect(page).to have_content 'Status: Em manutenção'
  end

  it 'e consegue visualizar os detalhes a partir da busca' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    vehicle = Vehicle.create!(sort: 'Carro', brand: 'Chevrolet', model: 'Meriva', identification:'CDF4G56', year_manufacture:'2019', max_load: 150)
    other_vehicle = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Doblo', identification:'ABC1D23', year_manufacture:'2019', max_load: 150)

    #Act
    login_as(user)
    visit root_url
    click_on 'Frota'
    click_on 'Veículos Cadastrados'
    fill_in 'Buscar Veículo', with: 'CDF'
    click_on 'Buscar'
    click_on 'CDF4G56'

    #Assert
    expect(current_url).to eq vehicle_url(vehicle.id)
  end

  it 'e volta para tela de listagem' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    vehicle = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Doblo', identification:'ABC1D23', year_manufacture:'2019', max_load: 150)

    #Act
    login_as(user)
    visit root_url
    click_on 'Frota'
    click_on 'Veículos Cadastrados'
    fill_in 'Buscar Veículo', with: 'ABC'
    click_on 'Buscar'
    click_on 'Voltar'
    
    #Assert
    expect(current_url).to eq vehicles_url
  end

end