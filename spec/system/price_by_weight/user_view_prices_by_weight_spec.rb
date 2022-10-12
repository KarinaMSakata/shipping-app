require 'rails_helper'
describe 'Usuário vê tabela de preços por peso' do
  it 'de acordo com a modalidade de transporte' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')
    one_price = PriceByWeight.create!(min_weight: 1, max_weight: 10, price_per_km: 0.50, mode_of_transport: mt)
    other_price = PriceByWeight.create!(min_weight: 11, max_weight: 30, price_per_km: 0.80, mode_of_transport: mt)

    #Act
    login_as(user)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'
    click_on 'Normal'

    #Assert
    expect(page).to have_content 'Tabela de Preço por Peso'
    expect(page).to have_css 'table', :text=> 'Intervalo'
    expect(page).to have_css 'table', :text=> 'Valor/Km'
    expect(page).to have_css 'table', :text=> '1kg'
    expect(page).to have_css 'table', :text=> '10kg'
    expect(page).to have_css 'table', :text=>  'R$ 0,50'
    expect(page).to have_css 'table', :text=>  '11kg'
    expect(page).to have_css 'table', :text=>  '30kg'
    expect(page).to have_css 'table', :text=>  'R$ 0,80'
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