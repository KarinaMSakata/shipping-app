require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe '#valid?' do
  context 'presence' do
    it 'tipo de veículo deve ser obrigatório' do
      #Arrange
      v = Vehicle.new(sort: '')

      #Act
      v.valid?

      #Assert
      expect(v.errors.include? :sort).to be true
    end

    it 'marca deve ser obrigatória' do
      #Arrange
      v = Vehicle.new(brand: '')

      #Act
      v.valid?

      #Assert
      expect(v.errors.include? :brand).to be true
    end

    it 'modelo deve ser obrigatório' do
      #Arrange
      v = Vehicle.new(model: '')

      #Act
      v.valid?

      #Assert
      expect(v.errors.include? :model).to be true
    end

    it 'placa de identificação deve ser obrigatória' do
      #Arrange
      v = Vehicle.new(identification: '')

      #Act
      v.valid?

      #Assert
      expect(v.errors.include? :identification).to be true
    end

    it 'ano de fabricação deve ser obrigatório' do
      #Arrange
      v = Vehicle.new(year_manufacture: '')

      #Act
      v.valid?

      #Assert
      expect(v.errors.include? :year_manufacture).to be true
    end

    it 'peso máximo deve ser obrigatório' do
      #Arrange
      v = Vehicle.new(max_load: '')

      #Act
      v.valid?

      #Assert
      expect(v.errors.include? :max_load).to be true
    end
  end

  context 'length' do
    it 'placa de identificação deve ter 7 caracteres' do
      #Arrange
      v = Vehicle.new(identification: 'ABCD1234')

      #Act
      v.valid?

      #Assert
      expect(v.errors.include? :identification).to be true
    end

    it 'ano de fabricacação deve ter 4 digitos' do
      #Arrange
      v = Vehicle.new(year_manufacture: 22)
    
      #Act
      v.valid?
    
      #Assert
      expect(v.errors.include? :year_manufacture).to be true
    end    
  end

  context 'numericality' do
    it 'peso máximo deve ser maior que 0' do
      #Arrange
      v = Vehicle.new(max_load: 0)
    
      #Act
      v.valid?
    
      #Assert
      expect(v.errors.include? :max_load).to be true
    end
  end

  context 'uniqueness' do
    it 'placa deve ser única' do
      #Arrange
      v = Vehicle.create!(sort: 'Carro', brand: 'Fiat', model: 'Doblo', identification:'ABC1D23', year_manufacture:'2019', max_load: 150, status: :in_operation)
      other_v = Vehicle.new(identification: 'ABC1D23')

      #Act
      other_v.valid?
    
      #Assert
      expect(other_v.errors.include? :identification).to be true
    end
  end

  end
end
