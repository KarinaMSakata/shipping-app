require 'rails_helper'

describe 'Usuário vê a listagem de veículos' do
  it 'se estiver autenticado' do
    #Arrange
    #Act
    visit root_url
    click_on 'Frota'
    click_on 'Veículos Cadastrados'

    #Assert
    expect(current_url).to eq new_user_session_url
  end

  it 'a partir de uma opção do menu' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    vehicle = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Doblo', identification:'ABC1D23', year_manufacture:'2019', max_load: 150)
    other_vehicle = Vehicle.create!(sort: 'Moto', brand: 'Dafra', model: 'CityClass', identification:'EFG4H56', year_manufacture:'2019', max_load: 20)

    #Act
    login_as(user)
    visit root_url
    click_on 'Frota'
    click_on 'Veículos Cadastrados'

    #Assert
    expect(current_url).to eq vehicles_url
  end
  
  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    vehicle = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Doblo', identification:'ABC1D23', year_manufacture:'2019', max_load: 150)
    other_vehicle = Vehicle.create!(sort: 'Moto', brand: 'Dafra', model: 'CityClass', identification:'EFG4H56', year_manufacture:'2019', max_load: 20)

    #Act
    login_as(user)
    visit root_url
    click_on 'Frota'
    click_on 'Veículos Cadastrados'

    #Assert
    expect(page).to have_content 'Frota'
    expect(page).to have_content 'Carro Fiat | Doblo'
    expect(page).to have_content 'Moto Dafra | CityClass'
  end

  it 'e não existem veículos cadastrados' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    
    #Act
    login_as(user)
    visit root_url
    click_on 'Frota'
    click_on 'Veículos Cadastrados'

    #Assert
    expect(page).to have_content 'Não existem veículos cadastrados'

  end
end