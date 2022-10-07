require 'rails_helper'

RSpec.describe PriceByWeight, type: :model do
  describe '#valid?' do
  context 'presence' do
    it 'peso mínimo é obrigatório' do
      #Arrange
      p = PriceByWeight.new(min_weight: '')

      #Act
      p.valid?

      #Assert
      expect(p.errors.include? :min_weight).to be true
    end

    it 'peso máximo é obrigatório' do
      #Arrange
      p = PriceByWeight.new(max_weight: '')

      #Act
      p.valid?

      #Assert
      expect(p.errors.include? :max_weight).to be true
    end

    it 'preço por km é obrigatório' do
      #Arrange
      p = PriceByWeight.new(price_per_km: '')

      #Act
      p.valid?

      #Assert
      expect(p.errors.include? :price_per_km).to be true
    end
  end
  end
end
