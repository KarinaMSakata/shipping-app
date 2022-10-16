require 'rails_helper'

describe 'Usuário edita uma ordem de serviço pendente' do 
  it 'a partir da página de listagem' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    os = CreateOrderOfService.create!(output_address: 'Av. das Pitangueiras, 100', output_city: 'São Paulo', output_state: 'SP',
                                      product_code: 'LG-LCD-49-5502-P', height: 50, width: 90, depth: 5, cargo_weight: 14,
                                      receiver_address: 'Rua das Flores, 20', receiver_city: 'Osasco', receiver_state: 'SP', 
                                      receiver_name: 'João de Almeida Santos', receiver_cpf: '37688849020', receiver_birth: '23/01/1990',
                                      total_distance: 41)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Ordem de Serviço'
    click_on 'Listar Ordens de Serviço'
    click_on os.code
    click_on 'Editar'

    #Assert
    expect(page).to have_content 'Editar Ordem de Serviço'
    expect(page).to have_content 'Dados para retirada do produto'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'Código do produto'
    expect(page).to have_content 'Dimensões do produto'
    expect(page).to have_field 'Altura(cm)'
    expect(page).to have_field 'Largura(cm)'
    expect(page).to have_field 'Profundidade(cm)'
    expect(page).to have_field 'Peso(Kg)'
    expect(page).to have_content 'Dados para entrega'
    expect(page).to have_field 'Endereço de entrega'
    expect(page).to have_field 'Cidade de entrega'
    expect(page).to have_field 'Estado de entrega' 
    expect(page).to have_field 'Destinatário'
    expect(page).to have_field 'CPF'
    expect(page).to have_field 'Data de nascimento'
    expect(page).to have_content 'Deslocamento a ser percorrido'
    expect(page).to have_field 'Distância total(Km)'
  end

  it 'e deve estar autenticado como admin' do
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
    expect(page).not_to have_link 'Editar'
    click_on 'Ordem de Serviço'
    click_on 'Listar Ordens de Serviço'
    click_on os.code
      
    #Assert
    expect(page).not_to have_link 'Editar'  
  end

  it 'com sucesso' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    os = CreateOrderOfService.create!(output_address: 'Av. das Pitangueiras, 100', output_city: 'São Paulo', output_state: 'SP',
                                      product_code: 'LG-LCD-49-5502-P', height: 50, width: 90, depth: 5, cargo_weight: 14,
                                      receiver_address: 'Rua das Flores, 20', receiver_city: 'Osasco', receiver_state: 'SP', 
                                      receiver_name: 'João de Almeida Santos', receiver_cpf: '37688849020', receiver_birth: '23/01/1990',
                                      total_distance: 41)
    #Act
    login_as(admin)
    visit root_url
    expect(page).not_to have_link 'Editar'
    click_on 'Ordem de Serviço'
    click_on 'Listar Ordens de Serviço'
    click_on os.code
    click_on 'Editar'
    fill_in 'Endereço', with: 'Av. Piratininga, 100'
    fill_in 'Cidade', with: 'Osasco'
    click_on 'Gravar'
      
    #Assert
    expect(page).to have_content 'Ordem de Serviço atualizada com sucesso.'
    expect(page).to have_content 'Endereço: Av. Piratininga, 100'
    expect(page).to have_content 'Cidade: Osasco'  
  end

  it 'e volta para lista' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    os = CreateOrderOfService.create!(output_address: 'Av. das Pitangueiras, 100', output_city: 'São Paulo', output_state: 'SP',
                                      product_code: 'LG-LCD-49-5502-P', height: 50, width: 90, depth: 5, cargo_weight: 14,
                                      receiver_address: 'Rua das Flores, 20', receiver_city: 'Osasco', receiver_state: 'SP', 
                                      receiver_name: 'João de Almeida Santos', receiver_cpf: '37688849020', receiver_birth: '23/01/1990',
                                      total_distance: 41)
    #Act
    login_as(admin)
    visit root_url
    expect(page).not_to have_link 'Editar'
    click_on 'Ordem de Serviço'
    click_on 'Listar Ordens de Serviço'
    click_on os.code
    click_on 'Editar'
    click_on 'Gravar'
    click_on 'Voltar para lista'
      
    #Assert
    expect(current_url).to eq create_order_of_services_url
  end
end