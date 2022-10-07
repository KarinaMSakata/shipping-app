require 'rails_helper'
describe 'Ususário vê a listagem de modalidades de transporte cadastradas' do
  it 'se estiver autenticado' do
    #Arrange
    #Act
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'

    #Assert
    expect(current_url).to eq new_user_session_url
  end

  it 'a partir de uma opção do menu' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    mt = ModeOfTransport.create!(name: 'Moto', min_distance: 1, max_distance: 80, min_weight: 1, max_weight: 10, fixed_rate: 5, status: 'activated')
    other_mt = ModeOfTransport.create!(name: 'Carro', min_distance: 1, max_distance: 500, min_weight: 10, max_weight: 30, fixed_rate: 15, status: 'activated')
    
    #Act
    login_as(user)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'

    #Assert
    expect(current_url).to eq mode_of_transports_url
  end

  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    mt = ModeOfTransport.create!(name: 'Moto', min_distance: 1, max_distance: 80, min_weight: 1, max_weight: 10, fixed_rate: 5, status: 'activated')
    other_mt = ModeOfTransport.create!(name: 'Carro', min_distance: 1, max_distance: 500, min_weight: 10, max_weight: 30, fixed_rate: 15, status: 'activated')
    
    #Act
    login_as(user)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'

    #Assert
    expect(page).to have_content 'Modalidades de Transporte'
    expect(page).to have_content 'Moto'
    expect(page).to have_content 'Carro'
  end

  it 'e não existem modalidades cadastradas' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)

    #Act
    login_as(user)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'

    #Assert
    expect(page).to have_content 'Não existem modalidades cadastradas.'

  end

  it 'se a modalidade estiver ativa' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    mt = ModeOfTransport.create!(name: 'Moto', min_distance: 1, max_distance: 80, min_weight: 1, max_weight: 10, fixed_rate: 5, status: 'activated')
    other_mt = ModeOfTransport.create!(name: 'Carro', min_distance: 1, max_distance: 500, min_weight: 10, max_weight: 30, fixed_rate: 15, status: 'disable')
    
    #Act
    login_as(user)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'

    #Assert
    expect(page).to have_content 'Modalidade de Transporte'
    expect(page).to have_content 'Moto'
    expect(page).not_to have_content 'Carro'
  end

  it 'e pode ver opções ativas e desativadas como administrador' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    mt = ModeOfTransport.create!(name: 'Moto', min_distance: 1, max_distance: 80, min_weight: 1, max_weight: 10, fixed_rate: 5, status: 'activated')
    other_mt = ModeOfTransport.create!(name: 'Carro', min_distance: 1, max_distance: 500, min_weight: 10, max_weight: 30, fixed_rate: 15, status: 'disable')
    
    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'

    #Assert
    expect(page).to have_content 'Modalidade de Transporte'
    expect(page).to have_content 'Moto'
    expect(page).to have_content 'Carro [Desativado]'
  end
end
