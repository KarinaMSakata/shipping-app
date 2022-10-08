require 'rails_helper'
describe 'Usuário vê tabela de preços por distância' do
  it 'e deve estar autenticado' do
    #Arrange
    #Act
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Preço por Distância'

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
    click_on 'Tabela de Preço por Distância'

    #Assert
    expect(current_url).to eq price_per_distances_url
  end

  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    one_price = PricePerDistance.create!(min_distance: 1, max_distance: 50, price: 9.00)
    other_price = PricePerDistance.create!(min_distance: 51, max_distance: 150, price: 12.00)
   
    #Act
    login_as(user)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Preço por Distância'

    #Assert
    expect(page).to have_content 'Tabela de Preço por Distância'
    expect(page).to have_css 'table', :text=> 'Intervalo'
    expect(page).to have_css 'table', :text=> 'Valor'
    expect(page).to have_css 'table', :text=> '1km'
    expect(page).to have_css 'table', :text=> '50km'
    expect(page).to have_css 'table', :text=>  'R$ 9,00'
    expect(page).to have_css 'table', :text=>  '51km'
    expect(page).to have_css 'table', :text=>  '150km'
    expect(page).to have_css 'table', :text=>  'R$ 12,00'
  end

  it 'e não existem valores cadastrados' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
   
    #Act
    login_as(user)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Preço por Distância'

    #Assert
    expect(page).to have_content 'Não existem valores cadastrados.'

  end
end