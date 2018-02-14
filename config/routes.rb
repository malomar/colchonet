Rails.application.routes.draw do
  # Idiomas suportados pela aplicação
  LOCALES = /en|pt\-BR/
  scope ":locale", locale: LOCALES do
    resources :rooms
    resources :users
  end

  # Para a página inicial respeitar o idioma
  get '/:locale' => 'home#index', locale: LOCALES
  
  root 'home#index'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
