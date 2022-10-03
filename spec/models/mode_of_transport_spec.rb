require 'rails_helper'

RSpec.describe ModeOfTransport, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'nome deve ser obrigatório' do 
        #Arrange
        mt = ModeOfTransport.new(name: '')

        #Act
        mt.valid?
        
        #Assert
        expect(mt.errors.include? :name).to be true
      end

      it 'distancia mínima deve ser obrigatória' do 
        #Arrange
        mt = ModeOfTransport.new(min_distance: '')

        #Act
        mt.valid?
        
        #Assert
        expect(mt.errors.include? :min_distance).to be true
      end

      it 'distancia máxima deve ser obrigatória' do 
        #Arrange
        mt = ModeOfTransport.new(max_distance: '')

        #Act
        mt.valid?
        
        #Assert
        expect(mt.errors.include? :max_distance).to be true
      end

      it 'peso mínimo deve ser obrigatório' do 
        #Arrange
        mt = ModeOfTransport.new(min_weight: '')

        #Act
        mt.valid?
        
        #Assert
        expect(mt.errors.include? :min_weight).to be true
      end

      it 'peso máximo deve ser obrigatório' do 
        #Arrange
        mt = ModeOfTransport.new(max_weight: '')

        #Act
        mt.valid?
        
        #Assert
        expect(mt.errors.include? :max_weight).to be true
      end

      it 'taxa fixa deve ser obrigatória' do 
        #Arrange
        mt = ModeOfTransport.new(fixed_rate: '')

        #Act
        mt.valid?
        
        #Assert
        expect(mt.errors.include? :fixed_rate).to be true
      end
    end

    context 'numericality' do
      it 'distância mínima deve ser maior do que 0' do
        #Arrange
        mt = ModeOfTransport.new(min_distance: 0)

        #Act
        mt.valid?

        #Assert
        expect(mt.errors.include? :min_distance).to be true
      end

      it 'peso mínimo deve ser maior do que 0' do
        #Arrange
        mt = ModeOfTransport.new(min_weight: 0)

        #Act
        mt.valid?

        #Assert
        expect(mt.errors.include? :min_weight).to be true
      end

      it 'taxa fixa mínima deve ser maior do que 0' do
        #Arrange
        mt = ModeOfTransport.new(fixed_rate: 0)

        #Act
        mt.valid?

        #Assert
        expect(mt.errors.include? :fixed_rate).to be true
      end

      it 'distância máxima deve ser menor do que 4.400' do
        #Arrange
        mt = ModeOfTransport.new(max_distance: 4_500)

        #Act
        mt.valid?

        #Assert
        expect(mt.errors.include? :max_distance).to be true
      end

      it 'peso máximo deve ser menor ou igual a 50' do
        #Arrange
        mt = ModeOfTransport.new(max_weight: 55)

        #Act
        mt.valid?

        #Assert
        expect(mt.errors.include? :max_weight).to be true
      end
    end
  end
end
