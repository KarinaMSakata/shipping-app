require 'rails_helper'
describe 'Usuário vê tabela de prazos de entrega' do
  it 'de acordo com a modalidade de transporte' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')
    one_time = DeliveryTime.create!(origin: 1, destination: 100, hours: 24, mode_of_transport: mt)
    other_time = DeliveryTime.create!(origin: 101, destination: 300, hours: 48, mode_of_transport: mt)
   
    #Act
    login_as(user)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'
    click_on 'Normal'

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
    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')

    #Act
    login_as(user)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'
    click_on 'Normal'

    #Assert
    expect(page).to have_content 'Não existem valores cadastrados.'
  end
end