require 'rails_helper'

describe 'Usuário vê detalhes de uma modalidade de transporte' do
  it 'a partir da listagem de modalidades' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    ModeOfTransport.create!(name: 'Moto', min_distance: 1, max_distance: 80, min_weight: 1, max_weight: 10, fixed_rate: 5, status: 'activated')
    
    #Act
    login_as(user)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'
    click_on 'Moto'

    #Assert
    expect(page).to have_content 'MOTO'
    expect(page).to have_content 'Distância Mínima Praticada: 1km'
    expect(page).to have_content 'Distância Máxima Praticada: 80km'
    expect(page).to have_content 'Peso Mínimo: 1kg'
    expect(page).to have_content 'Peso Máximo: 10kg'
    expect(page).to have_content 'Taxa Fixa: R$ 5,00'
    expect(page).to have_content 'Status: Ativo'

  end

  it 'e volta para tela de listagem' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    ModeOfTransport.create!(name: 'Moto', min_distance: 1, max_distance: 80, min_weight: 1, max_weight: 10, fixed_rate: 5, status: 'activated')
    
    #Act
    login_as(user)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'
    click_on 'Moto'
    click_on 'Voltar'

    #Arrange
    expect(current_url).to eq mode_of_transports_url

  end
  
  it 'e vê sua própria tabela de preço por peso' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4300, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')
    price = PriceByWeight.create!(min_weight: 1, max_weight: 10, price_per_km: 0.50, mode_of_transport: mt)

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
  end

end