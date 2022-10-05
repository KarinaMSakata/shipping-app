require 'rails_helper'
describe 'Usuário edita modalidade de transporte' do

  it 'e deve estar autenticado como admin' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role:'admin')
    ModeOfTransport.create!(name: 'Moto', min_distance: 1, max_distance: 80, min_weight: 1, max_weight: 10, fixed_rate: 5)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'
    click_on 'Moto'
    click_on 'Editar'
    
    #Assert
    expect(page).to have_content 'Editar Modalidade de Transporte'
    expect(page).to have_field 'Distância Mínima Praticada', with: 1
    expect(page).to have_field 'Distância Máxima Praticada', with: 80
    expect(page).to have_field 'Peso Mínimo', with: 1
    expect(page).to have_field 'Peso Máximo', with: 10
    expect(page).to have_field 'Taxa Fixa', with: 5
  end

  it 'com sucesso' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role:'admin')
    ModeOfTransport.create!(name: 'Moto', min_distance: 1, max_distance: 80, min_weight: 1, max_weight: 10, fixed_rate: 5)

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
  end
end