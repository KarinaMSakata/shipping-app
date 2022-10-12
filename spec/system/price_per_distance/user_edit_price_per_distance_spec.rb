require 'rails_helper'
describe 'Usuário edita uma configuração de preço por distância' do
  it 'a partir da modalidade de transporte' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')
    one_price = PricePerDistance.create!(min_distance: 1, max_distance: 50, price: 9.00, mode_of_transport: mt)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'
    click_on 'Normal'
    within 'table' do
      click_on 'Editar'
    end
      
    #Assert
    expect(page).to have_content 'Editar Preço por Distância'
    expect(page).to have_field 'Distância mínima(km)', with: 1
    expect(page).to have_field 'Distância máxima(km)', with: 50
    expect(page).to have_field 'Valor', with: 9.00
  end

  it 'e deve estar autenticado como admin' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')
    one_price = PricePerDistance.create!(min_distance: 1, max_distance: 50, price: 9.00, mode_of_transport: mt)

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
    one_price = PricePerDistance.create!(min_distance: 1, max_distance: 50, price: 9.00, mode_of_transport: mt)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'
    click_on 'Normal'
    within 'table' do
      click_on 'Editar'
    end
    fill_in 'Distância máxima(km)', with: 80
    fill_in 'Valor', with: 10.00 
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Valores atualizados com sucesso.'
    expect(page).to have_css 'table', :text=> '1km'
    expect(page).to have_css 'table', :text=> '80km'
    expect(page).to have_css 'table', :text=>  'R$ 10,00'
  end

  it 'e campos permanecem obrigatórios' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')
    one_price = PricePerDistance.create!(min_distance: 1, max_distance: 50, price: 9.00, mode_of_transport: mt)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'
    click_on 'Normal'
    within 'table' do
      click_on 'Editar'
    end
    fill_in 'Distância máxima(km)', with: nil
    fill_in 'Valor', with: nil 
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Não foi possivel atualizar os valores.'
  end
end