require 'rails_helper'

RSpec.describe CreateOrderOfService, type: :model do
  describe '#valid?' do
    context 'presence' do 
      it 'endereço de saída é obrigatório' do
        #Arrange
        os = CreateOrderOfService.new(output_address: '')

        #Act
        os.valid?

        #Assert
        expect(os.errors.include? :output_address).to be true
      end

      it 'cidade de saída é obrigatória' do
        #Arrange
        os = CreateOrderOfService.new(output_city: '')

        #Act
        os.valid?

        #Assert
        expect(os.errors.include? :output_city).to be true
      end

      it 'estado de saída é obrigatório' do
        #Arrange
        os = CreateOrderOfService.new(output_state: '')

        #Act
        os.valid?

        #Assert
        expect(os.errors.include? :output_state).to be true
      end

      it 'código do produto é obrigatório' do
        #Arrange
        os = CreateOrderOfService.new(product_code: '')

        #Act
        os.valid?

        #Assert
        expect(os.errors.include? :product_code).to be true
      end

      it 'peso da carga é obrigatória' do
        #Arrange
        os = CreateOrderOfService.new(cargo_weight: '')

        #Act
        os.valid?

        #Assert
        expect(os.errors.include? :cargo_weight).to be true
      end

      it 'endereço de entrega é obrigatório' do
        #Arrange
        os = CreateOrderOfService.new(receiver_address: '')

        #Act
        os.valid?

        #Assert
        expect(os.errors.include? :receiver_address).to be true
      end

      it 'cidade de entrega é obrigatória' do
        #Arrange
        os = CreateOrderOfService.new(receiver_city: '')

        #Act
        os.valid?

        #Assert
        expect(os.errors.include? :receiver_city).to be true
      end
      
      it 'estado de entrega é obrigatório' do
        #Arrange
        os = CreateOrderOfService.new(receiver_state: '')

        #Act
        os.valid?

        #Assert
        expect(os.errors.include? :receiver_state).to be true
      end

      it 'nome do destinatário é obrigatório' do
        #Arrange
        os = CreateOrderOfService.new(receiver_name: '')

        #Act
        os.valid?

        #Assert
        expect(os.errors.include? :receiver_name).to be true
      end

      it 'cpf do destinatário é obrigatório' do
        #Arrange
        os = CreateOrderOfService.new(receiver_cpf: '')

        #Act
        os.valid?

        #Assert
        expect(os.errors.include? :receiver_cpf).to be true
      end

      it 'data de nascimento do destinatário é obrigatório' do
        #Arrange
        os = CreateOrderOfService.new(receiver_birth: '')

        #Act
        os.valid?

        #Assert
        expect(os.errors.include? :receiver_birth).to be true
      end

      it 'distância total é obrigatória' do
        #Arrange
        os = CreateOrderOfService.new(total_distance: '')

        #Act
        os.valid?

        #Assert
        expect(os.errors.include? :total_distance).to be true
      end

      it 'código é obrigatório' do
        #Arrange
        os = CreateOrderOfService.new(output_address: 'Av. das Pitangueiras, 100', output_city: 'São Paulo', output_state: 'SP',
                                      product_code: 'LG-LCD-49-5502-P', height: 50, width: 90, depth: 5, cargo_weight: 14,
                                      receiver_address: 'Rua das Flores, 20', receiver_city: 'Osasco', receiver_state: 'SP', 
                                      receiver_name: 'João de Almeida Santos', receiver_cpf: '37688849020', receiver_birth: '23/01/1990',
                                      total_distance: 41)
    
        #Act
        #Assert
        expect(os.valid?).to be true
        
      end

    end

    context 'numericality' do
      it 'peso não pode ultrapassar 10_000' do
        #Arrange
        os = CreateOrderOfService.new(cargo_weight: 12_000)

        #Act
        os.valid?

        #Assert
        expect(os.errors.include? :cargo_weight).to be true
      end

      it 'CPF do destinatário deve ter somente números' do
        #Arrange
        os = CreateOrderOfService.new(receiver_cpf: '376.888.490-20')

        #Act
        os.valid?

        #Assert
        expect(os.errors.include? :receiver_cpf).to be true
      end

      it 'distância total não pode ultrapassar 4400' do
        #Arrange
        os = CreateOrderOfService.new(total_distance: 4450)

        #Act
        os.valid?

        #Assert
        expect(os.errors.include? :total_distance).to be true
      end
    end

    context 'length' do
      it 'código do produto deve ter no máximo 18 caracteres' do
        #Arrange
        os = CreateOrderOfService.new(product_code: 'LG-LCD-49-5502-PBAM')

        #Act
        os.valid?

        #Assert
        expect(os.errors.include? :product_code).to be true
      end
      
      it 'CPF do destinatário deve ter 11 números' do
        #Arrange
        os = CreateOrderOfService.new(receiver_cpf: '376888490200')

        #Act
        os.valid?

        #Assert
        expect(os.errors.include? :receiver_cpf).to be true
      end
    end
  end

  describe 'status pendente' do
    it 'ao criar uma nova ordem de serviço' do
      #Arrange
      os = CreateOrderOfService.create!(output_address: 'Av. das Pitangueiras, 100', output_city: 'São Paulo', output_state: 'SP',
                                        product_code: 'LG-LCD-49-5502-P', height: 50, width: 90, depth: 5, cargo_weight: 14,
                                        receiver_address: 'Rua das Flores, 20', receiver_city: 'Osasco', receiver_state: 'SP', 
                                        receiver_name: 'João de Almeida Santos', receiver_cpf: '37688849020', receiver_birth: '23/01/1990',
                                        total_distance: 41)
      #Act
      os.save!

      #Assert
      expect(os.status).to eq 'pending'  
    end
  end

  describe 'gera código automático' do
    it 'ao criar uma nova ordem de serviço' do
      #Arrange
      os = CreateOrderOfService.create!(output_address: 'Av. das Pitangueiras, 100', output_city: 'São Paulo', output_state: 'SP',
                                        product_code: 'LG-LCD-49-5502-P', height: 50, width: 90, depth: 5, cargo_weight: 14,
                                        receiver_address: 'Rua das Flores, 20', receiver_city: 'Osasco', receiver_state: 'SP', 
                                        receiver_name: 'João de Almeida Santos', receiver_cpf: '37688849020', receiver_birth: '23/01/1990',
                                        total_distance: 41)
                                    
      #Act
      os.save!

      #Assert
      expect(os.code).not_to be_empty
      expect(os.code.length).to eq 15
    end

    it 'e o código é único' do
      #Arrange
      os = CreateOrderOfService.create!(output_address: 'Av. das Pitangueiras, 100', output_city: 'São Paulo', output_state: 'SP',
                                        product_code: 'LG-LCD-49-5502-P', height: 50, width: 90, depth: 5, cargo_weight: 14,
                                        receiver_address: 'Rua das Flores, 20', receiver_city: 'Osasco', receiver_state: 'SP', 
                                        receiver_name: 'João de Almeida Santos', receiver_cpf: '37688849020', receiver_birth: '23/01/1990',
                                        total_distance: 41)

      other_os = CreateOrderOfService.new(output_address: 'Av. dos Limões, 30', output_city: 'Sorocaba', output_state: 'SP',
                                          product_code: 'SAMS-TV-50-4520-P', height: 50, width: 90, depth: 5, cargo_weight: 14,
                                          receiver_address: 'Rua das Rosas, 100', receiver_city: 'São Paulo', receiver_state: 'SP', 
                                          receiver_name: 'Maria Cristina Santos', receiver_cpf: '36982512358', receiver_birth: '04/10/1980',
                                          total_distance: 100)
                                    
      #Act
      other_os.save!

      #Assert
      expect(other_os.code).not_to eq os.code
    end

    it 'e não deve ser modificado' do
      #Arrange
      os = CreateOrderOfService.create!(output_address: 'Av. das Pitangueiras, 100', output_city: 'São Paulo', output_state: 'SP',
                                        product_code: 'LG-LCD-49-5502-P', height: 50, width: 90, depth: 5, cargo_weight: 14,
                                        receiver_address: 'Rua das Flores, 20', receiver_city: 'Osasco', receiver_state: 'SP', 
                                        receiver_name: 'João de Almeida Santos', receiver_cpf: '37688849020', receiver_birth: '23/01/1990',
                                        total_distance: 41)        
     
      original_code = os.code
      #Act

      os.update!(output_address: 'Av. das Amoreiras, 100')

      #Assert
      expect(os.code).to eq original_code
    end
  end
end
