require 'rails_helper'
describe 'Usuário edita modalidade de transporte' do

  it 'e deve estar autenticado como admin' do
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
    expect(page).not_to have_link 'Editar'
  end

  it 'com sucesso' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    ModeOfTransport.create!(name: 'Moto', min_distance: 1, max_distance: 80, min_weight: 1, max_weight: 10, fixed_rate: 5, status: 'activated')

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'
    click_on 'Moto'
    click_on 'Editar'
    fill_in 'Distância Mínima Praticada', with: 2
    fill_in 'Distância Máxima Praticada', with: 90
    fill_in 'Taxa Fixa', with: 10
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Modalidade de Transporte atualizada com sucesso.'
    expect(page).to have_content 'Distância Mínima Praticada: 2km'
    expect(page).to have_content 'Distância Máxima Praticada: 90km'
    expect(page).to have_content 'Taxa Fixa: R$ 10,00'
    expect(page).to have_content 'Status: Ativo'
  end

  it 'e dados permanecem obrigatórios' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    ModeOfTransport.create!(name: 'Moto', min_distance: 1, max_distance: 80, min_weight: 1, max_weight: 10, fixed_rate: 5, status: 'activated')

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'
    click_on 'Moto'
    click_on 'Editar'
    fill_in 'Distância Mínima Praticada', with: nil
    fill_in 'Distância Máxima Praticada', with: nil
    fill_in 'Taxa Fixa', with: nil
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Não foi possível atualizar a modalidade de transporte.'
  end


  it 'e desativa modalidade' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    ModeOfTransport.create!(name: 'Moto', min_distance: 1, max_distance: 80, min_weight: 1, max_weight: 10, fixed_rate: 5, status: 'activated')

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'
    click_on 'Moto'
    click_on 'Desativar'
  
    #Assert
    expect(page).to have_content 'Status: Desativado'
  end
end