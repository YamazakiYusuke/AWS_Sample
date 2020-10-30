Rails.application.routes.draw do
  scope "/:locale" do
    root to:'tasks#index'
    resources :tasks
  end
end
