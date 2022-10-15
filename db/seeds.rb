#Usuários
User.create!(name: 'Ana Maria', email: 'anamaria@sistemadefrete.com.br', password:'password', role: :admin)
User.create!(name: 'Carlos Antonio', email: 'carlos@sistemadefrete.com.br', password: 'password', role: :user)

#Modalidades de Transporte
express = ModeOfTransport.create!(name: 'Express', min_distance: 1, max_distance: 2000, min_weight: 1, max_weight: 5000, fixed_rate: 15, status: :activated)
economica = ModeOfTransport.create!(name: 'Econômica', min_distance: 1, max_distance: 3000, min_weight: 1, max_weight: 8000, fixed_rate: 5, status: :activated)
padrao = ModeOfTransport.create!(name: 'Padrão', min_distance: 1, max_distance: 4000, min_weight: 1, max_weight: 10000, fixed_rate: 10, status: :activated)

#Preço por Peso
first_price_express = PriceByWeight.create!(min_weight: 1, max_weight: 100, price_per_km: 1.50, mode_of_transport: express)
second_price_express = PriceByWeight.create!(min_weight: 101, max_weight: 400, price_per_km: 2.25, mode_of_transport: express)
thrid_price_express = PriceByWeight.create!(min_weight: 401, max_weight: 900, price_per_km: 3.00, mode_of_transport: express)
forth_price_express = PriceByWeight.create!(min_weight: 901, max_weight: 2000, price_per_km: 3.40, mode_of_transport: express)

first_price_economica = PriceByWeight.create!(min_weight: 1, max_weight: 500, price_per_km: 0.50, mode_of_transport: economica)
second_price_economica = PriceByWeight.create!(min_weight: 501, max_weight: 1000, price_per_km: 0.80, mode_of_transport: economica)
thrid_price_economica = PriceByWeight.create!(min_weight: 1001, max_weight: 2000, price_per_km: 1.00, mode_of_transport: economica)
forth_price_economica = PriceByWeight.create!(min_weight: 2001, max_weight: 3000, price_per_km: 1.50, mode_of_transport: economica)

first_price_padrao = PriceByWeight.create!(min_weight: 1, max_weight: 1000, price_per_km: 1.00, mode_of_transport: padrao)
second_price_padrao = PriceByWeight.create!(min_weight: 1001, max_weight: 2000, price_per_km: 1.50, mode_of_transport: padrao)
thrid_price_padrao = PriceByWeight.create!(min_weight: 2001, max_weight: 3000, price_per_km: 2.00, mode_of_transport: padrao)
forth_price_padrao = PriceByWeight.create!(min_weight: 3001, max_weight: 4000, price_per_km: 2.50, mode_of_transport: padrao)

#Preço por Distância
first_price_distance_express = PricePerDistance.create!(min_distance: 1, max_distance: 250, price: 12.00, mode_of_transport: express)
second_price_distance_express = PricePerDistance.create!(min_distance: 251, max_distance: 500, price: 17.00, mode_of_transport: express)
third_price_distance_express = PricePerDistance.create!(min_distance: 501, max_distance: 1000, price: 20.00, mode_of_transport: express)
forth_price_distance_express = PricePerDistance.create!(min_distance: 1001, max_distance: 2000, price: 23.00, mode_of_transport: express)

first_price_distance_economica = PricePerDistance.create!(min_distance: 1, max_distance: 500, price: 5.00, mode_of_transport: economica)
second_price_distance_economica = PricePerDistance.create!(min_distance: 501, max_distance: 1000, price: 8.00, mode_of_transport: economica)
third_price_distance_economica = PricePerDistance.create!(min_distance: 1001, max_distance: 1500, price: 13.00, mode_of_transport: economica)
forth_price_distance_economica = PricePerDistance.create!(min_distance: 1501, max_distance: 3000, price: 15.00, mode_of_transport: economica)

first_price_distance_padrao = PricePerDistance.create!(min_distance: 1, max_distance: 500, price: 9.00, mode_of_transport: padrao)
second_price_distance_padrao = PricePerDistance.create!(min_distance: 501, max_distance: 1000, price: 13.00, mode_of_transport: padrao)
third_price_distance_padrao = PricePerDistance.create!(min_distance: 1001, max_distance: 2000, price: 16.00, mode_of_transport: padrao)
forth_price_distance_padrao = PricePerDistance.create!(min_distance: 2001, max_distance: 4000, price: 19.00, mode_of_transport: padrao)

#Tempo de Entrega
first_time_express = DeliveryTime.create!(origin: 1, destination: 500, hours: 24, mode_of_transport: express)
second_time_express = DeliveryTime.create!(origin: 501, destination: 1000, hours: 36, mode_of_transport: express)
third_time_express = DeliveryTime.create!(origin: 1001, destination: 2000, hours: 48, mode_of_transport: express)

first_time_economica = DeliveryTime.create!(origin: 1, destination: 1000, hours: 72, mode_of_transport: economica)
second_time_economica = DeliveryTime.create!(origin: 1001, destination: 2000, hours: 96, mode_of_transport: economica)
third_time_economica = DeliveryTime.create!(origin: 2001, destination: 3000, hours: 120, mode_of_transport: economica)

first_time_padrao = DeliveryTime.create!(origin: 1, destination: 1000, hours: 60, mode_of_transport: padrao)
second_time_padrao = DeliveryTime.create!(origin: 1001, destination: 2000, hours: 84, mode_of_transport: padrao)
third_time_padrao = DeliveryTime.create!(origin: 2001, destination: 4000, hours: 108, mode_of_transport: padrao)

#Veículos
moto_1 = Vehicle.create!(sort: 'Moto', brand: 'Honda', model: 'CG 160 Titan', identification:'ABC1E85', year_manufacture:'2019', max_load: 160, status: :in_operation )
moto_2 = Vehicle.create!(sort: 'Moto', brand: 'Honda', model: 'CG 160 Fan', identification:'CBD5D77', year_manufacture:'2019', max_load: 160, status: :in_operation)
moto_3 = Vehicle.create!(sort: 'Moto', brand: 'Honda', model: 'CG 160 Star', identification:'LLS7D88', year_manufacture:'2019', max_load: 160, status: :in_maintenance)
carro_1 = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Doblo', identification:'ABC1D23', year_manufacture:'2019', max_load: 620, status: :in_maintenance)
carro_2 = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Fiorino', identification:'EFG4H56', year_manufacture:'2020', max_load: 650, status: :in_operation)
carro_3 = Vehicle.create!(sort: 'Carro', brand: 'Mercedes', model: 'Sprinter', identification:'HIJ7K89', year_manufacture:'2021', max_load: 2000, status: :in_operation)
caminhao_1 = Vehicle.create!(sort: 'Caminhão', brand: 'Ford', model: 'F-350', identification:'LMN7O89', year_manufacture:'2018', max_load: 10000, status: :in_operation)
caminhao_2 = Vehicle.create!(sort: 'Caminhão', brand: 'Ford', model: 'Cargo 1119', identification:'OPQ3F22', year_manufacture:'2020', max_load: 10000, status: :in_operation)
caminhao_3 = Vehicle.create!(sort: 'Caminhão', brand: 'Ford', model: 'XPTO11', identification:'STU1V22', year_manufacture:'2020', max_load: 10000, status: :in_maintenance)

#Ordem de Serviço
  
os_1 = CreateOrderOfService.create!(output_address: 'Av. das Pitangueiras, 100', output_city: 'São Paulo', output_state: 'SP',
                                    product_code: 'LG-LCD-49-5502-P', height: 50, width: 90, depth: 5, cargo_weight: 14,
                                    receiver_address: 'Rua das Flores, 20', receiver_city: 'Osasco', receiver_state: 'SP', 
                                    receiver_name: 'João de Almeida Santos', receiver_cpf: '37688849020', receiver_birth: '23/01/1990',
                                    total_distance: 41)

os_2 = CreateOrderOfService.create!(output_address: 'Av. das Amoras, 50', output_city: 'São Paulo', output_state: 'SP',
                                    product_code: 'DELL-32-8899-P', height: 40, width: 60, depth: 5, cargo_weight: 5,
                                    receiver_address: 'Rua dos Estados, 99', receiver_city: 'Sorocaba', receiver_state: 'SP', 
                                    receiver_name: 'Maria das Neves', receiver_cpf: '36985214785', receiver_birth: '10/05/1980',
                                    total_distance: 90)

os_3 = CreateOrderOfService.create!(output_address: 'Av. das Laranjas, 80', output_city: 'São Paulo', output_state: 'SP',
                                    product_code: 'SAMS-15-NOTE-B', height: 45, width: 5, depth: 30, cargo_weight: 2,
                                    receiver_address: 'Rua das Frutas, 99', receiver_city: 'Campo Grande', receiver_state: 'MS', 
                                    receiver_name: 'Cristina Silva', receiver_cpf: '35795145625', receiver_birth: '06/10/1989',
                                    total_distance: 987)

os_4 = CreateOrderOfService.create!(output_address: 'Av. das Laranjas, 80', output_city: 'São Paulo', output_state: 'SP',
                                    product_code: 'ELET-GEL-C589-P', height: 1800, width: 83, depth: 75, cargo_weight: 100,
                                    receiver_address: 'Rua das Marés, 99', receiver_city: 'São Luis do Maranhão', receiver_state: 'MA', 
                                    receiver_name: 'Jorge Amado', receiver_cpf: '68578925812', receiver_birth: '15/07/1989',
                                    total_distance: 2886)
