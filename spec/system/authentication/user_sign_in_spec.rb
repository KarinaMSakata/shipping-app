require 'rails_helper'
describe 'Usuário se autentica' do

  it 'com sucesso' do
    #Arrange
    User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password:'password', role:'admin')

    #Act
    visit root_url
    click_on 'Entrar'
    fill_in 'E-mail', with: 'karina@sistemadefrete.com.br' 
    fill_in 'Senha', with: 'password'
    click_on 'Avançar'

    #Assert
    expect(page).to have_content 'Login efetuado com sucesso.'
    expect(page).not_to have_link 'Entrar'
    expect(page).to have_button 'Sair'
  end

  it 'se o email for de dominio @sistemadefrete.com.br' do
    #Arrange
    User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password: 'password', role:'admin')

    #Act 
    visit root_url
    click_on 'Entrar'
    fill_in 'E-mail', with: 'karina@email.com'
    fill_in 'Senha', with: 'password'
    click_on 'Avançar'
    
    #Assert
    expect(page).to have_content 'E-mail ou senha inválidos.'
  end

  it 'e faz logout' do
     #Arrange
     user = User.create!(name: 'Karina', email: 'karina@sistemadefrete.com.br', password: 'password', role:'user')

     #Act
     visit root_url
     click_on 'Entrar'
     fill_in 'E-mail', with: 'karina@sistemadefrete.com.br'
     fill_in 'Senha', with: 'password'
     click_on 'Avançar'
     click_on 'Sair'
     
     #Assert
     expect(page).to have_link 'Entrar'
     expect(page).not_to have_button 'Sair'
  end
end