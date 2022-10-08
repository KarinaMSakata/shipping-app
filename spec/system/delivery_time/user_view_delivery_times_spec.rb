require 'rails_helper'
describe 'Usuário vê tabela de prazos de entrega' do
  it 'e deve estar autenticado' do
    #Arrange
    #Act
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Prazo de Entrega'

    #Assert
    expect(current_url).to eq new_user_session_url
  end

  it 'a partir de uma opção no menu' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)

    #Act
    login_as(user)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Prazo de Entrega'

    #Assert
    expect(current_url).to eq delivery_times_url
  end

  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    one_time = DeliveryTime.create!(origin: 1, destination: 100, hours: 24)
    other_time = DeliveryTime.create!(origin: 101, destination: 300, hours: 48)
   
    #Act
    login_as(user)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Prazo de Entrega'

    #Assert
    expect(page).to have_content 'Tabela de Prazo de Entrega'
    expect(page).to have_css 'table', :text=> 'Intervalo de distância entre:'
    expect(page).to have_css 'table', :text=> 'Origem(km)'
    expect(page).to have_css 'table', :text=> 'Destino(km)'
    expect(page).to have_css 'table', :text=> 'Prazo'
    expect(page).to have_css 'table', :text=> '1km'
    expect(page).to have_css 'table', :text=> '100km'
    expect(page).to have_css 'table', :text=>  '24 horas'
    expect(page).to have_css 'table', :text=>  '101km'
    expect(page).to have_css 'table', :text=>  '300km'
    expect(page).to have_css 'table', :text=>  '48 horas'
  end

  it 'e não existem prazos cadastrados' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
   
    #Act
    login_as(user)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Prazo de Entrega'

    #Assert
    expect(page).to have_content 'Não existem valores cadastrados.'
  end
end