require 'rails_helper'
describe 'Usuário finaliza uma ordem em andamento' do
  it 'encerrando no sistema' do
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
    click_on 'Listar Ordens de Serviço'
    click_on os.code
    click_on 'Encerrar Ordem de Serviço'
    click_on 'Voltar'

    #Assert
    expect(page).to have_content 'Status: Concluído'
    expect(page).not_to have_content 'Status: Em andamento'
    expect(page).not_to have_content 'Status: Pendente'
    expect(page).not_to have_button 'Iniciar Ordem de Serviço'
  end

  it 'e vê ordens com status concluído' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    os = CreateOrderOfService.create!(output_address: 'Av. das Pitangueiras, 100', output_city: 'São Paulo', output_state: 'SP',
                                      product_code: 'LG-LCD-49-5502-P', height: 50, width: 90, depth: 5, cargo_weight: 14,
                                      receiver_address: 'Rua das Flores, 20', receiver_city: 'Osasco', receiver_state: 'SP', 
                                      receiver_name: 'João de Almeida Santos', receiver_cpf: '37688849020', receiver_birth: '23/01/1990',
                                      total_distance: 41, status: :finish)
  
    #Act
    login_as(user)
    visit root_url
    click_on 'Ordem de Serviço'
    click_on 'Listar Ordens de Serviço'

    #Assert
    expect(page).to have_content "Código de rastreio: #{os.code}"
    expect(page).to have_content 'Destinatário: João de Almeida Santos'
    expect(page).to have_content 'Status: '
  end

  it 'e veículo deve ficar disponível novamente' do
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
    click_on 'Iniciar Ordem de Serviço'
    click_on 'Encerrar Ordem de Serviço'
    click_on 'Frota'
    click_on 'Veículos Cadastrados'

    #Assert
    expect(page).to have_content 'Carro Fiat | Doblo [Em operação]'
  end

  it 'e sistema indica a hora que foi encerrada' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)

    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')
  
    time = DeliveryTime.create!(origin: 1, destination: 100, hours: 48, mode_of_transport: mt)

    price_weight = PriceByWeight.create!(min_weight: 11, max_weight: 50, price_per_km: 0.50, mode_of_transport: mt)

    price_distance = PricePerDistance.create!(min_distance: 1, max_distance: 50, price: 9.00, mode_of_transport: mt)

    vehicle = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Doblo', identification:'ABC1D23', year_manufacture:'2019', max_load: 150, status: :in_operation)

    os = CreateOrderOfService.create!(output_address: 'Av. das Pitangueiras, 100', output_city: 'São Paulo', output_state: 'SP',
                                      product_code: 'LG-LCD-49-5502-P', height: 50, width: 90, depth: 5, cargo_weight: 14,
                                      receiver_address: 'Rua das Flores, 20', receiver_city: 'Osasco', receiver_state: 'SP', 
                                      receiver_name: 'João de Almeida Santos', receiver_cpf: '37688849020', receiver_birth: '23/01/1990',
                                      total_distance: 41, status: :initiated)
    
    SendOption.create!(mode_of_transport: mt, vehicle: vehicle, create_order_of_service: os)

    #Act
    login_as(user)
    visit root_url
    click_on 'Ordem de Serviço'
    click_on 'Listar Ordens de Serviço'
    click_on os.code
    click_on 'Encerrar Ordem de Serviço'

    #Assert
    expect(current_url).to eq end_order_create_order_of_service_url(os.id)
    expect(page).to have_content 'Ordem de Serviço concluída com sucesso!'
    expect(page).to have_content "Previsão de entrega: #{I18n.l((Time.now+48.hours).to_date)}"
    expect(page).to have_content 'Status de encerramento: Encerrada no prazo'
    expect(page).to have_content "Data de encerramento: #{I18n.l((Time.now).to_date)}" 
    expect(page).to have_link 'Voltar'
  end

  it 'fora do prazo estipulado' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)

    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')
  
    time = DeliveryTime.create!(origin: 1, destination: 100, hours: -36, mode_of_transport: mt)

    price_weight = PriceByWeight.create!(min_weight: 11, max_weight: 50, price_per_km: 0.50, mode_of_transport: mt)

    price_distance = PricePerDistance.create!(min_distance: 1, max_distance: 50, price: 9.00, mode_of_transport: mt)

    vehicle = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Doblo', identification:'ABC1D23', year_manufacture:'2019', max_load: 150, status: :in_operation)

    os = CreateOrderOfService.create!(output_address: 'Av. das Pitangueiras, 100', output_city: 'São Paulo', output_state: 'SP',
                                      product_code: 'LG-LCD-49-5502-P', height: 50, width: 90, depth: 5, cargo_weight: 14,
                                      receiver_address: 'Rua das Flores, 20', receiver_city: 'Osasco', receiver_state: 'SP', 
                                      receiver_name: 'João de Almeida Santos', receiver_cpf: '37688849020', receiver_birth: '23/01/1990',
                                      total_distance: 41, status: :initiated)
    
    SendOption.create!(mode_of_transport: mt, vehicle: vehicle, create_order_of_service: os)

    #Act
    login_as(user)
    visit root_url
    click_on 'Ordem de Serviço'
    click_on 'Listar Ordens de Serviço'
    click_on os.code
    click_on 'Encerrar Ordem de Serviço'

    #Assert
    expect(page).to have_content 'Status de encerramento: Encerrada com atraso'
    expect(page).to have_content "Previsão de entrega: #{I18n.l((Time.now+(-36).hours).to_date)}"
    expect(page).to have_content "Data de encerramento: #{I18n.l(Time.now.to_date)}" 
    expect(page).to have_field 'Motivo do atraso'
    expect(page).to have_button 'Salvar'
    expect(page).to have_link 'Voltar'
  
  end

  it 'e quando atrasado, descreve o motivo do atraso' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)

    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')
  
    time = DeliveryTime.create!(origin: 1, destination: 100, hours: -36, mode_of_transport: mt)

    price_weight = PriceByWeight.create!(min_weight: 11, max_weight: 50, price_per_km: 0.50, mode_of_transport: mt)

    price_distance = PricePerDistance.create!(min_distance: 1, max_distance: 50, price: 9.00, mode_of_transport: mt)

    vehicle = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Doblo', identification:'ABC1D23', year_manufacture:'2019', max_load: 150, status: :in_operation)

    os = CreateOrderOfService.create!(output_address: 'Av. das Pitangueiras, 100', output_city: 'São Paulo', output_state: 'SP',
                                      product_code: 'LG-LCD-49-5502-P', height: 50, width: 90, depth: 5, cargo_weight: 14,
                                      receiver_address: 'Rua das Flores, 20', receiver_city: 'Osasco', receiver_state: 'SP', 
                                      receiver_name: 'João de Almeida Santos', receiver_cpf: '37688849020', receiver_birth: '23/01/1990',
                                      total_distance: 41, status: :initiated)
    
    SendOption.create!(mode_of_transport: mt, vehicle: vehicle, create_order_of_service: os)

    #Act
    login_as(user)
    visit root_url
    click_on 'Ordem de Serviço'
    click_on 'Listar Ordens de Serviço'
    click_on os.code
    click_on 'Encerrar Ordem de Serviço'
    fill_in 'Motivo do atraso', with: 'Endereço de destino informado incorretamente.'
    click_on 'Salvar'

    #Assert
    expect(page).to have_content 'Motivo do atraso: Endereço de destino informado incorretamente.'

  end

  it 'e pode ver o status após a entrega ser finalizada' do 
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)

    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')
  
    time = DeliveryTime.create!(origin: 1, destination: 100, hours: -36, mode_of_transport: mt)

    price_weight = PriceByWeight.create!(min_weight: 11, max_weight: 50, price_per_km: 0.50, mode_of_transport: mt)

    price_distance = PricePerDistance.create!(min_distance: 1, max_distance: 50, price: 9.00, mode_of_transport: mt)

    vehicle = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Doblo', identification:'ABC1D23', year_manufacture:'2019', max_load: 150, status: :in_operation)

    os = CreateOrderOfService.create!(output_address: 'Av. das Pitangueiras, 100', output_city: 'São Paulo', output_state: 'SP',
                                      product_code: 'LG-LCD-49-5502-P', height: 50, width: 90, depth: 5, cargo_weight: 14,
                                      receiver_address: 'Rua das Flores, 20', receiver_city: 'Osasco', receiver_state: 'SP', 
                                      receiver_name: 'João de Almeida Santos', receiver_cpf: '37688849020', receiver_birth: '23/01/1990',
                                      total_distance: 41, status: :initiated)
    
    SendOption.create!(mode_of_transport: mt, vehicle: vehicle, create_order_of_service: os)
    #Act
    login_as(user)
    visit root_url
    click_on 'Ordem de Serviço'
    click_on 'Listar Ordens de Serviço'
    click_on os.code
    click_on 'Encerrar Ordem de Serviço'
    fill_in 'Motivo do atraso', with: 'Endereço de destino informado incorretamente.'
    click_on 'Salvar'
    click_on 'Voltar'
    click_on 'Ver situação da entrega'

    #Assert
    expect(page).to have_content 'Motivo do atraso: Endereço de destino informado incorretamente.'

  end

end