require 'rails_helper'
describe 'Usuário cadastra nova configuração de prazo por distância' do
  it 'para cada modalidade de transporte' do
    #Arrage
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'
    click_on 'Normal'
    click_on 'Cadastrar Novo Prazo de Entrega'

    #Assert
    expect(page).to have_content 'Cadastro de Prazo de Entrega'
    expect(page).to have_field 'Origem(km)'
    expect(page).to have_field 'Destino(km)'
    expect(page).to have_field 'Prazo'
  end

  it 'e deve estar autenticado como admin' do
    #Arrage
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')

    #Act
    login_as(user)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'
    click_on 'Normal'

    #Assert
    expect(page).not_to have_link 'Cadastrar Novo Prazo de Entrega'
  end

  it 'com sucesso' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'
    click_on 'Normal'
    click_on 'Cadastrar Novo Prazo de Entrega'
    fill_in 'Origem(km)', with: 1
    fill_in 'Destino(km)', with: 100
    fill_in 'Prazo', with: 48
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Prazo de Entrega cadastrado com sucesso!'
    expect(page).to have_content 'Tabela de Prazo de Entrega'
    expect(page).to have_css 'table', :text=> 'Intervalo de distância entre:'
    expect(page).to have_css 'table', :text=> 'Origem(km)'
    expect(page).to have_css 'table', :text=> 'Destino(km)'
    expect(page).to have_css 'table', :text=> 'Prazo'
    expect(page).to have_css 'table', :text=> '1km'
    expect(page).to have_css 'table', :text=> '100km'
    expect(page).to have_css 'table', :text=>  '48 horas'
  end

  it 'e dados são obrigatórios' do
    #Arrage
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'
    click_on 'Normal'
    click_on 'Cadastrar Novo Prazo de Entrega'
    fill_in 'Origem(km)', with: nil
    fill_in 'Destino(km)', with: nil
    fill_in 'Prazo', with: nil
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Não foi possível cadastrar esta configuração de preço.'
  end
end