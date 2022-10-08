require 'rails_helper'
describe 'Usuário edita uma configuração de preço por distância' do
  it 'a partir de uma opção na página da tabela de preço por distância' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    one_price = PricePerDistance.create!(min_distance: 1, max_distance: 50, price: 9.00)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Preço por Distância'
    click_on 'Editar'
      
    #Assert
    expect(page).to have_content 'Editar Preço por Distância'
    expect(page).to have_field 'Distância mínima(km)', with: 1
    expect(page).to have_field 'Distância máxima(km)', with: 50
    expect(page).to have_field 'Valor', with: 9.00
  end

  it 'e deve estar autenticado como admin' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    one_price = PricePerDistance.create!(min_distance: 1, max_distance: 50, price: 9.00)

    #Act
    login_as(user)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Preço por Distância'
      
    #Assert
    expect(page).not_to have_link 'Editar'
  end

  it 'com sucesso' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    one_price = PricePerDistance.create!(min_distance: 1, max_distance: 50, price: 9.00)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Preço por Distância'
    click_on 'Editar'
    fill_in 'Distância máxima(km)', with: 80
    fill_in 'Valor', with: 10.00 
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Valores atualizados com sucesso.'
    expect(page).to have_content 'Distância máxima(km): 80km'
    expect(page).to have_content 'Valor: R$ 10,00'
  end

  it 'e campos permanecem obrigatórios' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    one_price = PricePerDistance.create!(min_distance: 1, max_distance: 50, price: 9.00)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Preço por Distância'
    click_on 'Editar'
    fill_in 'Distância mínima(km)', with: nil
    fill_in 'Distância máxima(km)', with: nil
    fill_in 'Valor', with: nil
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Não foi possivel atualizar os valores.'
  end

  it 'e volta para tabela' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    one_price = PricePerDistance.create!(min_distance: 1, max_distance: 50, price: 9.00)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Preço por Distância'
    click_on 'Editar'
    click_on 'Gravar'
    click_on 'Voltar para Tabela'

    #Assert
    expect(current_url).to eq price_per_distances_url
  end

  it 'e volta para volta tela de edição' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    one_price = PricePerDistance.create!(min_distance: 1, max_distance: 50, price: 9.00)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Preço por Distância'
    click_on 'Editar'
    click_on 'Gravar'
    click_on 'Editar'

    #Assert
    expect(current_url).to eq edit_price_per_distance_url(one_price.id)
  end


end