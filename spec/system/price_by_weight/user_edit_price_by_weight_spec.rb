require 'rails_helper'
describe 'Usuário edita uma configuração de preço por peso' do
  it 'a partir de uma opção na página da tabela de preços por peso' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    one_price = PriceByWeight.create!(min_weight: 1, max_weight: 10, price_per_km: 0.50)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Preços por Peso'
    click_on 'Editar'
      
    #Assert
    expect(page).to have_content 'Editar Preço por Peso'
    expect(page).to have_field 'Peso mínimo(kg)', with: 1
    expect(page).to have_field 'Peso máximo(kg)', with: 10
      expect(page).to have_field 'Valor/Km', with: 0.50
  end

  it 'e deve estar autenticado como admin' do
    #Arrange
    user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :user)
    one_price = PriceByWeight.create!(min_weight: 1, max_weight: 10, price_per_km: 0.50)

    #Act
    login_as(user)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Preços por Peso'
      
    #Assert
    expect(page).not_to have_link 'Editar'
  end

  it 'com sucesso' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    one_price = PriceByWeight.create!(min_weight: 1, max_weight: 10, price_per_km: 0.50)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Preços por Peso'
    click_on 'Editar'
    fill_in 'Peso mínimo(kg)', with: 2
    fill_in 'Peso máximo(kg)', with: 20
    fill_in 'Valor/Km', with: 1.00  
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Valores atualizados com sucesso.'
    expect(page).to have_content 'Peso mínimo(kg): 2kg'
    expect(page).to have_content 'Peso máximo(kg): 20kg'
    expect(page).to have_content 'Valor/Km: R$ 1,00'
    end

  it 'e campos permanecem obrigatórios' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    one_price = PriceByWeight.create!(min_weight: 1, max_weight: 10, price_per_km: 0.50)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Preços por Peso'
    click_on 'Editar'
    fill_in 'Peso mínimo(kg)', with: nil
    fill_in 'Peso máximo(kg)', with: nil
    click_on 'Gravar'

    #Assert
    expect(page).to have_content 'Não foi possivel atualizar os valores.'
  end

  it 'e volta para tabela' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    one_price = PriceByWeight.create!(min_weight: 1, max_weight: 10, price_per_km: 0.50)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Preços por Peso'
    click_on 'Editar'
    click_on 'Gravar'
    click_on 'Voltar para Tabela'

    #Assert
    expect(current_url).to eq price_by_weights_url
  end

  it 'e volta para volta tela de edição' do
    #Arrange
    admin = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role: :admin)
    one_price = PriceByWeight.create!(min_weight: 1, max_weight: 10, price_per_km: 0.50)

    #Act
    login_as(admin)
    visit root_url
    click_on 'Modalidade de Transporte'
    click_on 'Tabela de Preços por Peso'
    click_on 'Editar'
    click_on 'Gravar'
    click_on 'Editar'

    #Assert
    expect(current_url).to eq edit_price_by_weight_url(one_price.id)
  end
end