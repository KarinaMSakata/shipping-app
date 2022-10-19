require 'rails_helper'
describe 'Usuário não autenticado busca por um pedido' do
  it 'a partir do menu' do
    #Arrange
    #Act
    visit root_url

    #Assert
    within 'header nav' do 
      expect(page).to have_field 'Acompanhe sua encomenda'
      expect(page).to have_button 'Buscar'
    end
  end 

  it 'e encontra um pedido em andamento' do 
    #Arrange
    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')

    time = DeliveryTime.create!(origin: 1, destination: 100, hours: 48, mode_of_transport: mt)

    price_weight = PriceByWeight.create!(min_weight: 11, max_weight: 50, price_per_km: 0.50, mode_of_transport: mt)

    price_distance = PricePerDistance.create!(min_distance: 1, max_distance: 50, price: 9.00, mode_of_transport: mt)

    doblo = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Doblo', identification:'ABC1D23', year_manufacture:'2019', max_load: 150, status: :in_operation)

    os = CreateOrderOfService.create!(output_address: 'Av. das Pitangueiras, 100', output_city: 'São Paulo', output_state: 'SP',
                                      product_code: 'LG-LCD-49-5502-P', height: 50, width: 90, depth: 5, cargo_weight: 14,
                                      receiver_address: 'Rua das Flores, 20', receiver_city: 'Osasco', receiver_state: 'SP', 
                                      receiver_name: 'João de Almeida Santos', receiver_cpf: '37688849020', receiver_birth: '23/01/1990',
                                      total_distance: 41, status: :initiated)

    SendOption.create!(mode_of_transport: mt, vehicle: doblo, create_order_of_service: os)
    #Act
    visit root_url
    fill_in 'Acompanhe sua encomenda', with: "#{os.code}"
    click_on 'Buscar'

    #Assert
    expect(page).to have_content "#{os.code}"
    expect(page).to have_content 'Informações de Rastreio'
    expect(page).to have_content 'Objeto Postado: São Paulo/SP'
    expect(page).to have_content 'Destino: Rua das Flores, 20 - Osasco/SP'
    expect(page).to have_content 'Veículo da entrega: Carro Fiat | Doblo - Placa ABC1D23'
    expect(page).to have_content "Previsão de entrega: #{I18n.localize(Time.now + (48.hours), format: :long)}"
  end

  it 'e não encontra o pedido' do 
    #Arrange
    #Act
    visit root_url
    fill_in 'Acompanhe sua encomenda', with: "ABCDEFGHJ101215"
    click_on 'Buscar'

    #Assert
    expect(page).to have_content 'Objeto não encontrado, verifique o código informado'
  end

  it 'e encontra um pedido já entregue' do 
    #Arrange
    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')

    time = DeliveryTime.create!(origin: 1, destination: 100, hours: 48, mode_of_transport: mt)

    price_weight = PriceByWeight.create!(min_weight: 11, max_weight: 50, price_per_km: 0.50, mode_of_transport: mt)

    price_distance = PricePerDistance.create!(min_distance: 1, max_distance: 50, price: 9.00, mode_of_transport: mt)

    doblo = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Doblo', identification:'ABC1D23', year_manufacture:'2019', max_load: 150, status: :in_operation)

    os = CreateOrderOfService.create!(output_address: 'Av. das Pitangueiras, 100', output_city: 'São Paulo', output_state: 'SP',
                                      product_code: 'LG-LCD-49-5502-P', height: 50, width: 90, depth: 5, cargo_weight: 14,
                                      receiver_address: 'Rua das Flores, 20', receiver_city: 'Osasco', receiver_state: 'SP', 
                                      receiver_name: 'João de Almeida Santos', receiver_cpf: '37688849020', receiver_birth: '23/01/1990',
                                      total_distance: 41, status: :finish)

    SendOption.create!(mode_of_transport: mt, vehicle: doblo, create_order_of_service: os)
    #Act
    visit root_url
    fill_in 'Acompanhe sua encomenda', with: "#{os.code}"
    click_on 'Buscar'

    #Assert
    expect(page).to have_content "#{os.code}"
    expect(page).to have_content 'Informações de Rastreio'
    expect(page).to have_content 'Objeto Postado: São Paulo/SP'
    expect(page).to have_content 'Destino: Rua das Flores, 20 - Osasco/SP'
    expect(page).to have_content 'Veículo da entrega: Carro Fiat | Doblo - Placa ABC1D23'
    expect(page).to have_content "Prazo de entrega inicial: #{I18n.localize((Time.now + (48.hours)).to_date)}"
    expect(page).to have_content "Objeto entregue ao destinatário em: #{I18n.localize(Time.now, format: :long)}"
  end

  it 'e encontra informações de um pedido pendente' do 
    #Arrange
    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')

    time = DeliveryTime.create!(origin: 1, destination: 100, hours: 48, mode_of_transport: mt)

    price_weight = PriceByWeight.create!(min_weight: 11, max_weight: 50, price_per_km: 0.50, mode_of_transport: mt)

    price_distance = PricePerDistance.create!(min_distance: 1, max_distance: 50, price: 9.00, mode_of_transport: mt)

    doblo = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Doblo', identification:'ABC1D23', year_manufacture:'2019', max_load: 150, status: :in_operation)

    os = CreateOrderOfService.create!(output_address: 'Av. das Pitangueiras, 100', output_city: 'São Paulo', output_state: 'SP',
                                      product_code: 'LG-LCD-49-5502-P', height: 50, width: 90, depth: 5, cargo_weight: 14,
                                      receiver_address: 'Rua das Flores, 20', receiver_city: 'Osasco', receiver_state: 'SP', 
                                      receiver_name: 'João de Almeida Santos', receiver_cpf: '37688849020', receiver_birth: '23/01/1990',
                                      total_distance: 41, status: :pending)

    #Act
    visit root_url
    fill_in 'Acompanhe sua encomenda', with: "#{os.code}"
    click_on 'Buscar'

    #Assert
    expect(page).to have_content "#{os.code}"
    expect(page).to have_content 'Informações de Rastreio'
    expect(page).to have_content 'Origem: São Paulo/SP'
    expect(page).to have_content 'Destino: Rua das Flores, 20 - Osasco/SP'
    expect(page).to have_content 'Objeto em análise.'
  end

  it 'e encontra um pedido já entregue com atraso' do 
    #Arrange
    mt = ModeOfTransport.create!(name: 'Normal', min_distance: 1, max_distance: 4390, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: 'activated')

    time = DeliveryTime.create!(origin: 1, destination: 100, hours: -48, mode_of_transport: mt)

    price_weight = PriceByWeight.create!(min_weight: 11, max_weight: 50, price_per_km: 0.50, mode_of_transport: mt)

    price_distance = PricePerDistance.create!(min_distance: 1, max_distance: 50, price: 9.00, mode_of_transport: mt)

    doblo = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Doblo', identification:'ABC1D23', year_manufacture:'2019', max_load: 150, status: :in_operation)

    os = CreateOrderOfService.create!(output_address: 'Av. das Pitangueiras, 100', output_city: 'São Paulo', output_state: 'SP',
                                      product_code: 'LG-LCD-49-5502-P', height: 50, width: 90, depth: 5, cargo_weight: 14,
                                      receiver_address: 'Rua das Flores, 20', receiver_city: 'Osasco', receiver_state: 'SP', 
                                      receiver_name: 'João de Almeida Santos', receiver_cpf: '37688849020', receiver_birth: '23/01/1990',
                                      total_distance: 41, status: :finish)

    SendOption.create!(mode_of_transport: mt, vehicle: doblo, create_order_of_service: os)

    Feedback.create!(description: "Entregador não encontrou o endereço informado.", create_order_of_service: os)
    #Act
    visit root_url
    fill_in 'Acompanhe sua encomenda', with: "#{os.code}"
    click_on 'Buscar'

    #Assert
    expect(page).to have_content "#{os.code}"
    expect(page).to have_content 'Informações de Rastreio'
    expect(page).to have_content 'Objeto Postado: São Paulo/SP'
    expect(page).to have_content 'Destino: Rua das Flores, 20 - Osasco/SP'
    expect(page).to have_content 'Veículo da entrega: Carro Fiat | Doblo - Placa ABC1D23'
    expect(page).to have_content "Prazo de entrega inicial: #{I18n.localize((Time.now + (-48.hours)).to_date)}"
    expect(page).to have_content "Objeto entregue ao destinatário em: #{I18n.localize(Time.now, format: :long)}"
    expect(page).to have_content 'Motivo do atraso: Entregador não encontrou o endereço informado.'
  end

end