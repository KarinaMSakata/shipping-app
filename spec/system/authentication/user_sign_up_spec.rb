require 'rails_helper'

describe 'Usuário cria autenticação' do 
  it 'com sucesso' do 
    #Arrange
    #Act
    visit root_url
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'Maria'
    fill_in 'E-mail', with: 'maria@sistemadefrete.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'
    
    #Assert
    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'Olá, Maria!' 
    expect(page).to have_button 'Sair'
  end
  
  it 'e dados são obrigatórios' do 
    #Arrange
    #Act
    visit root_url
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in 'Nome', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirme sua senha', with: ''
    click_on 'Criar conta'
    
    #Assert
    expect(page).to have_content 'Não foi possível salvar usuário'
    expect(page).to have_content 'Nome não pode ficar em branco'
  end

  it 'e domínio deve ser @sistemadefrete.com.br' do 
    #Arrange
    #Act
    visit root_url
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'Maria'
    fill_in 'E-mail', with: 'maria@gmail.com  '
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'
    
    #Assert
    expect(page).not_to have_link 'Sair'
    expect(page).to have_content 'Não foi possível salvar usuário'
    expect(page).to have_content 'E-mail não é válido'
  end
end 