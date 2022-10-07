require 'rails_helper'

describe 'Usuário vê detalhes de um veículo' do
  it 'a partir da listagem de veículos' do 
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    vehicle = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Doblo', identification:'ABC1D23', year_manufacture:'2019', max_load: 150)
    other_vehicle = Vehicle.create!(sort: 'Moto', brand: 'Dafra', model: 'CityClass', identification:'EFG4H56', year_manufacture:'2019', max_load: 20)

    #Act
    login_as(user)
    visit root_url
    click_on 'Frota'
    click_on 'Veículos Cadastrados'
    click_on 'Carro Fiat | Doblo'

    #Assert
    expect(page).to have_content 'Detalhes de Carro Fiat | Doblo'
    expect(page).to have_content 'Tipo: Carro'
    expect(page).to have_content 'Marca: Fiat'
    expect(page).to have_content 'Modelo: Doblo'
    expect(page).to have_content 'Placa de identificação: ABC1D23'
    expect(page).to have_content 'Ano de fabricação: 2019'
    expect(page).to have_content 'Capacidade máxima de carga (peso): 150kg'  
    expect(page).to have_content 'Status: Em manutenção'
  end

  it 'e volta para listagem' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    vehicle = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Doblo', identification:'ABC1D23', year_manufacture:'2019', max_load: 150)
    other_vehicle = Vehicle.create!(sort: 'Moto', brand: 'Dafra', model: 'CityClass', identification:'EFG4H56', year_manufacture:'2019', max_load: 20)

    #Act
    login_as(user)
    visit root_url
    click_on 'Frota'
    click_on 'Veículos Cadastrados'
    click_on 'Carro Fiat | Doblo'
    click_on 'Voltar'

    #Assert
    expect(current_url).to eq vehicles_url
 
  end

end