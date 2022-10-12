require 'rails_helper'
describe 'Usuário vê tabela de preços por distância' do
  it 'de acordo com a modalidade de transporte' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')
    one_price = PricePerDistance.create!(min_distance: 1, max_distance: 50, price: 9.00, mode_of_transport: mt)
    other_price = PricePerDistance.create!(min_distance: 51, max_distance: 150, price: 12.00, mode_of_transport: mt)
   
    #Act
    login_as(user)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'
    click_on 'Normal'

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