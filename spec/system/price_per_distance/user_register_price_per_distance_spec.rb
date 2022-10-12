require 'rails_helper'
describe 'Usuário cadastra nova configuração de preço por distância' do
  it 'para cada modalidade de transporte' do
    #Arrage
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'
    click_on 'Normal'
    click_on 'Cadastrar Novo Preço por Distância'

    #Assert
    expect(page).to have_content 'Cadastro de Preço por Distância'
    expect(page).to have_field 'Distância mínima(km)'
    expect(page).to have_field 'Distância máxima(km)'
    expect(page).to have_field 'Valor'
  end

  it 'e deve estar autenticado como admin' do
    #Arrage
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')

    #Act
    login_as(user)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'
    click_on 'Normal'

    #Assert
    expect(page).not_to have_link 'Cadastrar Novo Preço por Distância'
  end

  it 'com sucesso' do
    #Arrage
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'
    click_on 'Normal'
    click_on 'Cadastrar Novo Preço por Distância'
    fill_in 'Distância mínima(km)', with: 1
    fill_in 'Distância máxima(km)', with: 50
    fill_in 'Valor', with: 9.00
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Configuração de preço cadastrada com sucesso!'
    expect(page).to have_content 'Tabela de Preço por Distância'
    expect(page).to have_css 'table', :text=> 'Intervalo'
    expect(page).to have_css 'table', :text=> 'Valor'
    expect(page).to have_css 'table', :text=> '1km'
    expect(page).to have_css 'table', :text=> '50km'
    expect(page).to have_css 'table', :text=>  'R$ 9,00'
  end

  it 'e dados são obrigatórios' do
    #Arrage
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Modalidades Cadastradas'
    click_on 'Normal'
    click_on 'Cadastrar Novo Preço por Distância'
    fill_in 'Distância mínima(km)', with: nil
    fill_in 'Distância máxima(km)', with: nil
    fill_in 'Valor', with: nil
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Não foi possível cadastrar esta configuração de preço.'
  end
end