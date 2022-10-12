require 'rails_helper'
describe 'Usuário cadastra nova configuração de preço por peso' do
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
    click_on 'Cadastrar Novo Preço por Peso'

    #Assert
    expect(page).to have_content 'Cadastro de Preço por Peso'
    expect(page).to have_field 'Peso mínimo(kg)'
    expect(page).to have_field 'Peso máximo(kg)'
    expect(page).to have_field 'Valor/Km'
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
    expect(page).not_to have_content 'Cadastrar Novo Preço por Peso'
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
    click_on 'Cadastrar Novo Preço por Peso'
    fill_in 'Peso mínimo(kg)', with: 1
    fill_in 'Peso máximo(kg)', with: 10
    fill_in 'Valor/Km', with: 0.50
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Configuração de preço cadastrada com sucesso!'
    expect(page).to have_content 'Tabela de Preço por Peso'
    expect(page).to have_css 'table', :text=> 'Intervalo'
    expect(page).to have_css 'table', :text=> 'Valor/Km'
    expect(page).to have_css 'table', :text=> '1kg'
    expect(page).to have_css 'table', :text=> '10kg'
    expect(page).to have_css 'table', :text=>  'R$ 0,50'
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
    click_on 'Cadastrar Novo Preço por Peso'
    fill_in 'Peso mínimo(kg)', with: nil
    fill_in 'Peso máximo(kg)', with: nil
    fill_in 'Valor/Km', with: nil
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Não foi possível cadastrar esta configuração de preço.'
  end 
end