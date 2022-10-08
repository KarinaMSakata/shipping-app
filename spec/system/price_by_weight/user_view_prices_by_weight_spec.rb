require 'rails_helper'
describe 'Usuário vê tabela de preços por peso' do
  it 'e deve estar autenticado' do
    #Arrange
    #Act
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Preços por Peso'

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
    click_on 'Tabela de Preços por Peso'

    #Assert
    expect(current_url).to eq price_by_weights_url
  end

  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    one_price = PriceByWeight.create!(min_weight: 1, max_weight: 10, price_per_km: 0.50)
    other_price = PriceByWeight.create!(min_weight: 11, max_weight: 30, price_per_km: 0.80)
   
    #Act
    login_as(user)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Preços por Peso'

    #Assert
    expect(page).to have_content 'Tabela de Preços por Peso'
    expect(page).to have_css 'table', :text=> 'Intervalo'
    expect(page).to have_css 'table', :text=> 'Valor/Km'
    expect(page).to have_css 'table', :text=> '1kg'
    expect(page).to have_css 'table', :text=> '10kg'
    expect(page).to have_css 'table', :text=>  'R$ 0,50'
    expect(page).to have_css 'table', :text=>  '11kg'
    expect(page).to have_css 'table', :text=>  '30kg'
    expect(page).to have_css 'table', :text=>  'R$ 0,80'
  end

  it 'e não existema valores cadastrados' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
   
    #Act
    login_as(user)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Preços por Peso'

    #Assert
    expect(page).to have_content 'Não existem valores cadastrados.'

  end
end