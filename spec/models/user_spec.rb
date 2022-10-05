require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
  context 'presence' do
    it 'nome deve ser obrigatório' do 
      #Arrange
      user = User.new(name: '')

      #Act
      user.valid?
      
      #Assert
      expect(user.errors.include? :name).to be true
    end

    it 'email deve ser obrigatório' do 
      #Arrange
      user = User.new(email: '')

      #Act
      user.valid?
      
      #Assert
      expect(user.errors.include? :email).to be true
    end

    it 'email deve ter domínio @sistemadefrete.com.br' do 
      #Arrange
      user = User.new(email: 'karina@gmail.com')

      #Act
      user.valid?
      
      #Assert
      expect(user.errors.include? :email).to be true
    end
  end
  end
end
