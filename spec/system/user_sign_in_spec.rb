require 'rails_helper'
describe 'Usuário se autentica' do
  it 'com sucesso' do
    #Arrange
    User.create!(email: 'karina@email.com', password: 'password')

    #Act 
    visit root_url
    click_on 'Entrar'
    fill_in 'E-mail', with: 'karina@email.com'
    fill_in 'Senha', with: 'password'
    click_on 'Avançar'
    
    #Assert
    expect(page).to have_content 'Login efetuado com sucesso.'
    within 'nav' do 
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'karina@email.com'
    end
  end

  it 'e faz logout' do
     #Arrange
     User.create!(email: 'karina@email.com', password: 'password')

     #Act 
     visit root_url
     click_on 'Entrar'
     fill_in 'E-mail', with: 'karina@email.com'
     fill_in 'Senha', with: 'password'
     click_on 'Avançar'
     click_on 'Sair'
     
     #Assert
     expect(page).to have_content 'Logout efetuado com sucesso.'
     expect(page).to have_link 'Entrar'
     expect(page).not_to have_button 'Sair'
     expect(page).not_to have_content 'karina@email.com'
  end
end