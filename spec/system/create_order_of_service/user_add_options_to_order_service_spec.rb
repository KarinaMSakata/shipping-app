require 'rails_helper'

describe 'Usuário adiciona Modalidade e Veículo na ordem de serviço' do
  it 'com sucesso' do
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    
    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')
    
    time = DeliveryTime.create!(origin: 1, destination: 100, hours: 48, mode_of_transport: mt)

    price_weight = PriceByWeight.create!(min_weight: 11, max_weight: 50, price_per_km: 0.50, mode_of_transport: mt)

    price_distance = PricePerDistance.create!(min_distance: 1, max_distance: 50, price: 9.00, mode_of_transport: mt)

    other_mt = ModeOfTransport.create!(name: 'Express', min_distance: 1, max_distance: 1000, min_weight: 1, max_weight: 5000, fixed_rate: 20, status: 'activated')
    
    other_time = DeliveryTime.create!(origin: 1, destination: 100, hours: 24, mode_of_transport: other_mt)

    other_price_weight = PriceByWeight.create!(min_weight: 11, max_weight: 50, price_per_km: 1.00, mode_of_transport: other_mt)

    other_price_distance = PricePerDistance.create!(min_distance: 1, max_distance: 50, price: 20.00, mode_of_transport: other_mt)

    vehicle = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Doblo', identification:'ABC1D23', year_manufacture:'2019', max_load: 150, status: :in_operation)

    other_vehicle = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Fiorino', identification:'ABC1D44', year_manufacture:'2019', max_load: 150, status: :in_operation)

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
    click_on os.code
    click_on 'Adicionar Modalidade e Veículo'
    select 'Normal | Prazo de Entrega: 48 horas', from: 'Modalidade de Transporte'
    check 'Veículo: Carro Fiat | Doblo'
    click_on 'Confirmar'

    #Assert
    expect(current_url).to eq create_order_of_service_url(os.id)
    expect(page).to have_content 'Modalidade e Veículo adicionados com sucesso.'
    expect(page).to have_content 'Modalidade e Veículo Selecionados'
    expect(page).to have_content 'Modalidade de Transporte: Normal'
    expect(page).to have_content 'Prazo de Entrega: 48 horas'
    expect(page).to have_content 'Valor Total: R$ 39,50'
    expect(page).to have_content 'Veículo: Carro Fiat | Doblo'

  end

  it 'e deve ser listada somente modalidades de transporte que atendam às condições da ordem de serviço' do
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    
    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 50, max_distance: 4390, min_weight: 20, max_weight: 10000, fixed_rate: 10, status: 'activated')
    
    time = DeliveryTime.create!(origin: 1, destination: 100, hours: 48, mode_of_transport: mt)

    price_weight = PriceByWeight.create!(min_weight: 20, max_weight: 50, price_per_km: 0.50, mode_of_transport: mt)

    price_distance = PricePerDistance.create!(min_distance: 50, max_distance: 100, price: 9.00, mode_of_transport: mt)

    other_mt = ModeOfTransport.create!(name: 'Express', min_distance: 1, max_distance: 1000, min_weight: 1, max_weight: 5000, fixed_rate: 20, status: 'activated')
    
    other_time = DeliveryTime.create!(origin: 1, destination: 100, hours: 24, mode_of_transport: other_mt)

    other_price_weight = PriceByWeight.create!(min_weight: 11, max_weight: 50, price_per_km: 1.00, mode_of_transport: other_mt)

    other_price_distance = PricePerDistance.create!(min_distance: 1, max_distance: 50, price: 20.00, mode_of_transport: other_mt)

    doblo = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Doblo', identification:'ABC1D23', year_manufacture:'2019', max_load: 150, status: :in_operation)

    fiorino = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Fiorino', identification:'ABC1D44', year_manufacture:'2019', max_load: 150, status: :in_operation)

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
    click_on os.code
    click_on 'Adicionar Modalidade e Veículo'


    #Assert
    expect(page).to have_content "Modalidade e Transporte para a Ordem de Serviço #{os.code}"
    expect(page).to have_select 'Modalidade de Transporte', text: 'Express | Prazo de Entrega: 24 horas'
    expect(page).not_to have_select 'Modalidade de Transporte', text: 'Normal | Prazo de Entrega: 48 horas'
    expect(page).to have_field 'Veículo: Carro Fiat | Doblo'

  end

  it 'e veículo deve ser incluído automaticamente' do
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    
    doblo = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Doblo', identification:'ABC1D23', year_manufacture:'2019', max_load: 150, status: :in_operation)

    fiorino = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Fiorino', identification:'ABC1D44', year_manufacture:'2019', max_load: 150, status: :in_operation)

    sprinter = Vehicle.create!(sort: 'Carro', brand: 'Mercedes', model: 'Sprinter', identification:'EDF1D23', year_manufacture:'2019', max_load: 150, status: :in_maintenance)

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
    click_on os.code
    click_on 'Adicionar Modalidade e Veículo'

    #Assert
    expect(page).to have_content 'Veículo: Carro Fiat | Doblo'
    expect(page).not_to have_content 'Veículo: Carro Fiat | Fiorino'
    expect(page).not_to have_content 'Veículo: Carro Mercedes | Sprinter'
  end
end