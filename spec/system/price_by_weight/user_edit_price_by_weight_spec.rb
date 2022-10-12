require 'rails_helper'
describe 'Usuário edita uma configuração de preço por peso' do
  it 'a partir da modalidade de transporte' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')
    one_price = PriceByWeight.create!(min_weight: 1, max_weight: 10, price_per_km: 0.50, mode_of_transport: mt)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'
    click_on 'Normal'
    within ("table") do
      click_on 'Editar'
    end
      
    #Assert
    expect(page).to have_content 'Editar Preço por Peso'
    expect(page).to have_field 'Peso mínimo(kg)', with: 1
    expect(page).to have_field 'Peso máximo(kg)', with: 10
    expect(page).to have_field 'Valor/Km', with: 0.50
  end

  it 'e deve estar autenticado como admin' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')
    one_price = PriceByWeight.create!(min_weight: 1, max_weight: 10, price_per_km: 0.50, mode_of_transport: mt)

    #Act
    login_as(user)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'
    click_on 'Normal'
      
    #Assert
    expect(page).not_to have_link 'Editar'
  end

  it 'com sucesso' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')
    one_price = PriceByWeight.create!(min_weight: 1, max_weight: 10, price_per_km: 0.50, mode_of_transport: mt)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'
    click_on 'Normal'
    within ("table") do
      click_on 'Editar'
    end
    fill_in 'Peso mínimo(kg)', with: 2
    fill_in 'Peso máximo(kg)', with: 20
    fill_in 'Valor/Km', with: 1.00  
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Valores atualizados com sucesso.'
    expect(page).to have_css 'table', :text=> '2kg'
    expect(page).to have_css 'table', :text=> '20kg'
    expect(page).to have_css 'table', :text=>  'R$ 1,00'
    end

  it 'e campos permanecem obrigatórios' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')
    one_price = PriceByWeight.create!(min_weight: 1, max_weight: 10, price_per_km: 0.50, mode_of_transport: mt)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'
    click_on 'Normal'
    within ("table") do
      click_on 'Editar'
    end
    fill_in 'Peso mínimo(kg)', with: nil
    fill_in 'Peso máximo(kg)', with: nil
    fill_in 'Valor/Km', with: nil
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Não foi possivel atualizar os valores.'
  end
end