require 'rails_helper'
describe 'Usuário vê detalhes da ordem de serviço' do
  it 'a partir da lista de ordens' do
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
    click_on 'Listar Ordens de Serviço'
    click_on os.code

    #Assert
    expect(page).to have_content 'Ordem de Serviço'
    expect(page).to have_content 'Status: Pendente'
    expect(page).to have_content "Código de rastreio: #{os.code}"
    expect(page).to have_content 'Dados para retirada do produto'
    expect(page).to have_content 'Endereço: Av. das Pitangueiras, 100'
    expect(page).to have_content 'Cidade: São Paulo'
    expect(page).to have_content 'Estado: SP'
    expect(page).to have_content 'Código do produto: LG-LCD-49-5502-P'
    expect(page).to have_content 'Dimensões do produto'
    expect(page).to have_content 'Altura(cm): 50cm'
    expect(page).to have_content 'Largura(cm): 90cm'
    expect(page).to have_content 'Profundidade(cm): 5cm'
    expect(page).to have_content 'Peso(Kg): 14kg'
    expect(page).to have_content 'Dados para entrega do produto'
    expect(page).to have_content 'Endereço de entrega: Rua das Flores, 20'
    expect(page).to have_content 'Cidade de entrega: Osasco'
    expect(page).to have_content 'Estado de entrega: SP'
    expect(page).to have_content 'Destinatário: João de Almeida Santos'
    expect(page).to have_content 'CPF: 376.888.490-20'
    expect(page).to have_content 'Data de nascimento: 23/01/1990'
    expect(page).to have_content 'Deslocamento a ser percorrido'
    expect(page).to have_content 'Distância total(Km): 41km'
  end

  it 'e vê opções para envio do produto' do

    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    
    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')
    
    time = DeliveryTime.create!(origin: 1, destination: 100, hours: 24, mode_of_transport: mt)

    price_weight = PriceByWeight.create!(min_weight: 11, max_weight: 50, price_per_km: 0.50, mode_of_transport: mt)

    price_distance = PricePerDistance.create!(min_distance: 1, max_distance: 50, price: 9.00, mode_of_transport: mt)

    vehicle = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Doblo', identification:'ABC1D23', year_manufacture:'2019', max_load: 150)
    
    os = CreateOrderOfService.create!(output_address: 'Av. das Pitangueiras, 100', output_city: 'São Paulo', output_state: 'SP',
                                      product_code: 'LG-LCD-49-5502-P', height: 50, width: 90, depth: 5, cargo_weight: 14,
                                      receiver_address: 'Rua das Flores, 20', receiver_city: 'Osasco', receiver_state: 'SP', 
                                      receiver_name: 'João de Almeida Santos', receiver_cpf: '37688849020', receiver_birth: '23/01/1990',
                                      total_distance: 41)
    
    SendOption.create!(mode_of_transport: mt, vehicle: vehicle, create_order_of_service: os)

    #Act
    login_as(user)
    visit root_url
    click_on 'Ordem de Serviço'
    click_on 'Listar Ordens de Serviço'
    click_on os.code

    #Assert
    expect(page).to have_content 'Modalidade e Veículo Selecionados'
    expect(page).to have_content 'Modalidade de Transporte: Normal'
    expect(page).to have_content 'Prazo de Entrega: 24 horas'
    expect(page).to have_content 'Valor Total: R$ 39,50'
    expect(page).to have_content 'Veículo: Carro Fiat | Doblo'
  end
end