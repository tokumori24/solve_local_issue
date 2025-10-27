Rails.application.routes.draw do
  # ルートパスをダッシュボードに設定
  root "dashboard#index"

  # 電気使用量のCRUD操作
  resources :electricity_usages, only: [ :index, :create, :destroy ]

  # ダッシュボード
  get "dashboard", to: "dashboard#index"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
