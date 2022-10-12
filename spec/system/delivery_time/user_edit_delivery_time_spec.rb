require 'rails_helper'
describe 'Usuário edita um prazo de entrega' do
  it 'a partir da modalidade de transporte' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')
    one_time = DeliveryTime.create!(origin: 1, destination: 100, hours: 24, mode_of_transport: mt)

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
    expect(page).to have_content 'Editar Prazo de Entrega'
    expect(page).to have_field 'Origem(km)', with: 1
    expect(page).to have_field 'Destino(km)', with: 100
    expect(page).to have_field 'Prazo', with: 24
  end

  it 'e deve estar autenticado como admin' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')
    one_time = DeliveryTime.create!(origin: 1, destination: 100, hours: 24, mode_of_transport: mt)

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
    one_time = DeliveryTime.create!(origin: 1, destination: 100, hours: 24, mode_of_transport: mt)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'
    click_on 'Normal'
    within 'table' do
      click_on 'Editar'
    end
    fill_in 'Destino(km)', with: 200
    fill_in 'Prazo', with: 36
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Prazo atualizado com sucesso!'
    expect(page).to have_css 'table', :text=> '200km'
    expect(page).to have_css 'table', :text=>  '36 horas'
  end

  it 'e campos permanecem obrigatórios' do 
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')
    one_time = DeliveryTime.create!(origin: 1, destination: 100, hours: 24, mode_of_transport: mt)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'
    click_on 'Normal'
    within 'table' do
      click_on 'Editar'
    end
    fill_in 'Destino(km)', with: nil
    fill_in 'Prazo', with: nil
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Não foi possível atualizar este prazo.'
  end
end
