require 'rails_helper'
describe 'Usuário edita um prazo de entrega' do
  it 'a partir de uma opção na página da tabela de prazo' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    one_time = DeliveryTime.create!(origin: 1, destination: 100, hours: 24)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Prazo de Entrega'
    click_on 'Editar'

    #Assert
    expect(page).to have_content 'Editar Prazo de Entrega'
    expect(page).to have_field 'Origem(km)', with: 1
    expect(page).to have_field 'Destino(km)', with: 100
    expect(page).to have_field 'Prazo', with: 24
  end

  it 'e deve estar autenticado como admin' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    one_time = DeliveryTime.create!(origin: 1, destination: 100, hours: 24)

    #Act
    login_as(user)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Prazo de Entrega'
      
    #Assert
    expect(page).not_to have_link 'Editar'
  end

  it 'com sucesso' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    one_time = DeliveryTime.create!(origin: 1, destination: 100, hours: 24)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Prazo de Entrega'
    click_on 'Editar'
    fill_in 'Destino(km)', with: 200
    fill_in 'Prazo', with: 36
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Prazo atualizado com sucesso!'
    expect(page).to have_content 'Destino(km): 200km'
    expect(page).to have_content 'Prazo: 36 horas'
  end

  it 'e campos permanecem obrigatórios' do 
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    one_time = DeliveryTime.create!(origin: 1, destination: 100, hours: 24)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Prazo de Entrega'
    click_on 'Editar'
    fill_in 'Origem(km)', with: nil
    fill_in 'Destino(km)', with: nil
    fill_in 'Prazo', with: nil
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Não foi possível atualizar este prazo.'
  end

  it 'e volta para a tabela' do 
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    one_time = DeliveryTime.create!(origin: 1, destination: 100, hours: 24)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Prazo de Entrega'
    click_on 'Editar'
    click_on 'Gravar'
    click_on 'Voltar para Tabela'

    #Assert
    expect(current_url).to eq delivery_times_url
  end

  it 'e volta para a tela de edição' do 
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    one_time = DeliveryTime.create!(origin: 1, destination: 100, hours: 24)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Prazo de Entrega'
    click_on 'Editar'
    click_on 'Gravar'
    click_on 'Editar'

    #Assert
    expect(current_url).to eq edit_delivery_time_url(one_time.id)
  end

end
