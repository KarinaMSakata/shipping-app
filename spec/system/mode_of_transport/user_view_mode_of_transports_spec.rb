require 'rails_helper'
describe 'Ususário vê a listagem de modalidades de transporte cadastradas' do
  it 'a partir de uma opção do menu' do
    #Arrange
    mt = ModeOfTransport.create!(name: 'Moto', min_distance: 1, max_distance: 80, min_weight: 1, max_weight: 10, fixed_rate: 5)
    other_mt = ModeOfTransport.create!(name: 'Carro', min_distance: 1, max_distance: 500, min_weight: 10, max_weight: 30, fixed_rate: 15)

    #Act
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'

    #Assert
    expect(current_url).to eq mode_of_transports_url
  end

  it 'com sucesso' do
    #Arrange
    mt = ModeOfTransport.create!(name: 'Moto', min_distance: 1, max_distance: 80, min_weight: 1, max_weight: 10, fixed_rate: 5)
    other_mt = ModeOfTransport.create!(name: 'Carro', min_distance: 1, max_distance: 500, min_weight: 10, max_weight: 30, fixed_rate: 15)

    #Act
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
    #Act
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'

    #Assert
    expect(page).to have_content 'Não existem modalidades cadastradas.'
  end
end
