require 'rails_helper'

describe 'Usuário altera modalidade de transporte' do
  it 'a partir da tela de detalhes da ordem de serviço' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)

    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')

    time = DeliveryTime.create!(origin: 1, destination: 100, hours: 48, mode_of_transport: mt)

    price_weight = PriceByWeight.create!(min_weight: 11, max_weight: 50, price_per_km: 0.50, mode_of_transport: mt)

    price_distance = PricePerDistance.create!(min_distance: 1, max_distance: 50, price: 9.00, mode_of_transport: mt)

    doblo = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Doblo', identification:'ABC1D23', year_manufacture:'2019', max_load: 150, status: :in_operation)

    os = CreateOrderOfService.create!(output_address: 'Av. das Pitangueiras, 100', output_city: 'São Paulo', output_state: 'SP',
                                      product_code: 'LG-LCD-49-5502-P', height: 50, width: 90, depth: 5, cargo_weight: 14,
                                      receiver_address: 'Rua das Flores, 20', receiver_city: 'Osasco', receiver_state: 'SP', 
                                      receiver_name: 'João de Almeida Santos', receiver_cpf: '37688849020', receiver_birth: '23/01/1990',
                                      total_distance: 41)

    SendOption.create!(mode_of_transport: mt, vehicle: doblo, create_order_of_service: os)
    
    #Act
    login_as(user)
    visit root_url
    click_on 'Ordem de Serviço'
    click_on 'Listar Ordens de Serviço'
    click_on os.code
    click_on 'Alterar Modalidade'

    #Assert
    expect(page).to have_content "Alterar Modalidade para a Ordem de Serviço #{os.code}"
    expect(page).to have_select 'Modalidade de Transporte', text: 'Normal'
    expect(page).to have_field 'Veículo: Carro Fiat | Doblo'
  end

  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)

    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')

    time = DeliveryTime.create!(origin: 1, destination: 100, hours: 48, mode_of_transport: mt)

    price_weight = PriceByWeight.create!(min_weight: 11, max_weight: 50, price_per_km: 0.50, mode_of_transport: mt)

    price_distance = PricePerDistance.create!(min_distance: 1, max_distance: 50, price: 9.00, mode_of_transport: mt)

    other_mt = ModeOfTransport.create!(name: 'Express', min_distance: 1, max_distance: 1000, min_weight: 1, max_weight: 5000, fixed_rate: 20, status: 'activated')
    
    other_time = DeliveryTime.create!(origin: 1, destination: 100, hours: 24, mode_of_transport: other_mt)

    other_price_weight = PriceByWeight.create!(min_weight: 11, max_weight: 50, price_per_km: 1.00, mode_of_transport: other_mt)

    other_price_distance = PricePerDistance.create!(min_distance: 1, max_distance: 50, price: 20.00, mode_of_transport: other_mt)

    doblo = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Doblo', identification:'ABC1D23', year_manufacture:'2019', max_load: 150, status: :in_operation)

    os = CreateOrderOfService.create!(output_address: 'Av. das Pitangueiras, 100', output_city: 'São Paulo', output_state: 'SP',
                                      product_code: 'LG-LCD-49-5502-P', height: 50, width: 90, depth: 5, cargo_weight: 14,
                                      receiver_address: 'Rua das Flores, 20', receiver_city: 'Osasco', receiver_state: 'SP', 
                                      receiver_name: 'João de Almeida Santos', receiver_cpf: '37688849020', receiver_birth: '23/01/1990',
                                      total_distance: 41)

    SendOption.create!(mode_of_transport: mt, vehicle: doblo, create_order_of_service: os)
    
    #Act
    login_as(user)
    visit root_url
    click_on 'Ordem de Serviço'
    click_on 'Listar Ordens de Serviço'
    click_on os.code
    click_on 'Alterar Modalidade'
    select 'Express', from: 'Modalidade de Transporte'
    click_on 'Confirmar'

    #Assert
    expect(page).to have_content "Modalidade alterada com sucesso"
    expect(page).to have_content 'Modalidade de Transporte: Express'
    expect(page).to have_content 'Prazo de Entrega: 24 horas'
    expect(page).to have_content 'Valor Total: R$ 81,00'    
    expect(page).to have_content 'Veículo: Carro Fiat | Doblo'
  end


end