require 'rails_helper'
describe 'Usuário vê ordem de serviço' do
  it 'e deve estar autenticado' do
    #Arrange
    #Act
    visit root_url
    click_on 'Ordem de Serviço'
    click_on 'Ordens de Serviço Pendentes'

    #Assert
    expect(current_url).to eq new_user_session_url
  end

  it 'a partir de uma opção no menu' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)

    #Act
    login_as(user)
    visit root_url
    click_on 'Ordem de Serviço'
    click_on 'Ordens de Serviço Pendentes'

    #Assert
    expect(current_url).to eq create_order_of_services_url
  end

  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    os = CreateOrderOfService.create!(output_address: 'Av. das Pitangueiras, 100', output_city: 'São Paulo', output_state: 'SP',
                                      product_code: 'LG-LCD-49-5502-P', height: 50, width: 90, depth: 5, cargo_weight: 14,
                                      receiver_address: 'Rua das Flores, 20', receiver_city: 'Osasco', receiver_state: 'SP', 
                                      receiver_name: 'João de Almeida Santos', receiver_cpf: '37688849020', receiver_birth: '23/01/1990',
                                      total_distance: 41)
  
    #Act
    login_as(user)
    visit root_url
    click_on 'Ordem de Serviço'
    click_on 'Ordens de Serviço Pendentes'

    #Assert
    expect(page).to have_content 'Ordens de Serviço Pendentes'
    expect(page).to have_content "Código de rastreio: #{os.code}"
    expect(page).to have_content 'Destinatário: João de Almeida Santos'
  end

  it 'e não exitem os pendentes' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    os = CreateOrderOfService.create!(output_address: 'Av. das Pitangueiras, 100', output_city: 'São Paulo', output_state: 'SP',
                                      product_code: 'LG-LCD-49-5502-P', height: 50, width: 90, depth: 5, cargo_weight: 14,
                                      receiver_address: 'Rua das Flores, 20', receiver_city: 'Osasco', receiver_state: 'SP', 
                                      receiver_name: 'João de Almeida Santos', receiver_cpf: '37688849020', receiver_birth: '23/01/1990',
                                      total_distance: 41, status: :initiated)
  
    #Act
    login_as(user)
    visit root_url
    click_on 'Ordem de Serviço'
    click_on 'Ordens de Serviço Pendentes'

    #Assert
    expect(page).to have_content 'Não existem ordens de serviço pendentes'
  end
end