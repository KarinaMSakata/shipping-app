require 'rails_helper'

RSpec.describe PricePerDistance, type: :model do
  describe '#valid?' do
    context 'presence' do 
     it 'distância mínima é obrigatória' do
      #Arrange 
      p = PricePerDistance.new(min_distance: '')

      #Act
      p.valid?

      #Assert
      expect(p.errors.include? :min_distance).to be true
     end

     it 'distância máxima é obrigatória' do
      #Arrange 
      p = PricePerDistance.new(max_distance: '')

      #Act
      p.valid?

      #Assert   
      expect(p.errors.include? :max_distance).to be true
     end

     it 'preço é obrigatório' do
      #Arrange 
      p = PricePerDistance.new(price: '')

      #Act
      p.valid?

      #Assert   
      expect(p.errors.include? :price).to be true
     end
    end
  end
end
