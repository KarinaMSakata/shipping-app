require 'rails_helper'

RSpec.describe DeliveryTime, type: :model do
  describe '#valid?' do
    context 'presence' do 
      it 'km de origem é obrigatória' do
        #Arrange 
        p = DeliveryTime.new(origin: '')

        #Act
        p.valid?

        #Assert
        expect(p.errors.include? :origin).to be true
      end

      it 'km de destino é obrigatório' do
        #Arrange 
        p = DeliveryTime.new(destination: '')

        #Act
        p.valid?

        #Assert
        expect(p.errors.include? :destination).to be true
      end

      it 'hora é obrigatória' do
        #Arrange 
        p = DeliveryTime.new(hours: '')

        #Act
        p.valid?

        #Assert
        expect(p.errors.include? :hours).to be true
      end
    end

    context 'numericality' do
      it 'km de origem deve ser maior ou igual a 1' do
        #Arrange 
        p = DeliveryTime.new(origin: 0)

        #Act
        p.valid?

        #Assert
        expect(p.errors.include? :origin).to be true
      end

      it 'km de destino deve ser menor que 4400' do
        #Arrange 
        p = DeliveryTime.new(destination: 4400)

        #Act
        p.valid?

        #Assert
        expect(p.errors.include? :destination).to be true
      end

      it 'horas deve ser maior ou igual a 24' do
        #Arrange 
        p = DeliveryTime.new(hours: 12)

        #Act
        p.valid?

        #Assert
        expect(p.errors.include? :hours).to be true
      end
    end
  end
end
