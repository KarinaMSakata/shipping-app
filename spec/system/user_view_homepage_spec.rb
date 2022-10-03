require 'rails_helper'

describe 'Usuário visita tela inicial' do
  it 'e vê nome da aplicação' do
    #Arrange
    #Act
    visit root_url

    #Assert
    expect(page).to have_content 'SGFE - Sistema Gerencial de Frete para E-commerce'
  end

  it 'e vê a opção de Modalidade de Transporte dentro de um menu' do
    #Arrange
    #Act
    visit root_url

    #Assert
    expect(page).to have_content 'Modalidade de Transporte'
  end
end
