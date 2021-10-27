# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'top#index'

  # 管理画面
  namespace :admin do
    root to: 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :users
    resources :dietary_reference_intakes, only: %i[index show destroy]
    resources :food_categories, only: %i[index edit update destroy]
    resources :foods, only: %i[index show edit update destroy]
    resources :suggestions, only: %i[index]
  end

  namespace :api, format: 'json' do
    namespace :v1 do
      resource :registration, only: %i[create]
      resource :authentication, only: %i[create destroy]
      resource :mypage, only: %i[show]
      resource :user_account, only: %i[show update]
      resource :user_withdrawal, only: %i[show destroy]
      resource :bmr, only: %i[update]
      resource :users_dietary_reference_intake, only: %i[update]
      resource :suggestion, only: %i[show]
      resources :food_categories, only: %i[] do
        resources :foods, only: %i[show]
      end
    end
  end

  namespace :line do
    post 'callback', to: 'linebot#callback', format: 'json'
    get 'link', to: 'authentications#link'
    post 'link', to: 'authentications#create'
  end

  # ルーティングエラーを拾う
  get '*path', to: 'top#index'
end

# == Route Map
#
#                                Prefix Verb   URI Pattern                                                                              Controller#Action
#                                  root GET    /                                                                                        top#index
#                            admin_root GET    /admin(.:format)                                                                         admin/dashboards#index
#                           admin_login GET    /admin/login(.:format)                                                                   admin/user_sessions#new
#                                       POST   /admin/login(.:format)                                                                   admin/user_sessions#create
#                          admin_logout DELETE /admin/logout(.:format)                                                                  admin/user_sessions#destroy
#                           admin_users GET    /admin/users(.:format)                                                                   admin/users#index
#                                       POST   /admin/users(.:format)                                                                   admin/users#create
#                        new_admin_user GET    /admin/users/new(.:format)                                                               admin/users#new
#                       edit_admin_user GET    /admin/users/:id/edit(.:format)                                                          admin/users#edit
#                            admin_user GET    /admin/users/:id(.:format)                                                               admin/users#show
#                                       PATCH  /admin/users/:id(.:format)                                                               admin/users#update
#                                       PUT    /admin/users/:id(.:format)                                                               admin/users#update
#                                       DELETE /admin/users/:id(.:format)                                                               admin/users#destroy
#       admin_dietary_reference_intakes GET    /admin/dietary_reference_intakes(.:format)                                               admin/dietary_reference_intakes#index
#        admin_dietary_reference_intake GET    /admin/dietary_reference_intakes/:id(.:format)                                           admin/dietary_reference_intakes#show
#                                       DELETE /admin/dietary_reference_intakes/:id(.:format)                                           admin/dietary_reference_intakes#destroy
#                 admin_food_categories GET    /admin/food_categories(.:format)                                                         admin/food_categories#index
#              edit_admin_food_category GET    /admin/food_categories/:id/edit(.:format)                                                admin/food_categories#edit
#                   admin_food_category PATCH  /admin/food_categories/:id(.:format)                                                     admin/food_categories#update
#                                       PUT    /admin/food_categories/:id(.:format)                                                     admin/food_categories#update
#                                       DELETE /admin/food_categories/:id(.:format)                                                     admin/food_categories#destroy
#                           admin_foods GET    /admin/foods(.:format)                                                                   admin/foods#index
#                       edit_admin_food GET    /admin/foods/:id/edit(.:format)                                                          admin/foods#edit
#                            admin_food GET    /admin/foods/:id(.:format)                                                               admin/foods#show
#                                       PATCH  /admin/foods/:id(.:format)                                                               admin/foods#update
#                                       PUT    /admin/foods/:id(.:format)                                                               admin/foods#update
#                                       DELETE /admin/foods/:id(.:format)                                                               admin/foods#destroy
#                     admin_suggestions GET    /admin/suggestions(.:format)                                                             admin/suggestions#index
#                   api_v1_registration POST   /api/v1/registration(.:format)                                                           api/v1/registrations#create {:format=>/json/}
#                 api_v1_authentication DELETE /api/v1/authentication(.:format)                                                         api/v1/authentications#destroy {:format=>/json/}
#                                       POST   /api/v1/authentication(.:format)                                                         api/v1/authentications#create {:format=>/json/}
#                         api_v1_mypage GET    /api/v1/mypage(.:format)                                                                 api/v1/mypages#show {:format=>/json/}
#                   api_v1_user_account GET    /api/v1/user_account(.:format)                                                           api/v1/user_accounts#show {:format=>/json/}
#                                       PATCH  /api/v1/user_account(.:format)                                                           api/v1/user_accounts#update {:format=>/json/}
#                                       PUT    /api/v1/user_account(.:format)                                                           api/v1/user_accounts#update {:format=>/json/}
#                api_v1_user_withdrawal GET    /api/v1/user_withdrawal(.:format)                                                        api/v1/user_withdrawals#show {:format=>/json/}
#                                       DELETE /api/v1/user_withdrawal(.:format)                                                        api/v1/user_withdrawals#destroy {:format=>/json/}
#                            api_v1_bmr PATCH  /api/v1/bmr(.:format)                                                                    api/v1/bmrs#update {:format=>/json/}
#                                       PUT    /api/v1/bmr(.:format)                                                                    api/v1/bmrs#update {:format=>/json/}
# api_v1_users_dietary_reference_intake PATCH  /api/v1/users_dietary_reference_intake(.:format)                                         api/v1/users_dietary_reference_intakes#update {:format=>/json/}
#                                       PUT    /api/v1/users_dietary_reference_intake(.:format)                                         api/v1/users_dietary_reference_intakes#update {:format=>/json/}
#                     api_v1_suggestion GET    /api/v1/suggestion(.:format)                                                             api/v1/suggestions#show {:format=>/json/}
#             api_v1_food_category_food GET    /api/v1/food_categories/:food_category_id/foods/:id(.:format)                            api/v1/foods#show {:format=>/json/}
#                         line_callback POST   /line/callback(.:format)                                                                 line/linebot#callback {:format=>/json/}
#                             line_link GET    /line/link(.:format)                                                                     line/authentications#link
#                                       POST   /line/link(.:format)                                                                     line/authentications#create
#                                       GET    /*path(.:format)                                                                         top#index
#         rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                  action_mailbox/ingresses/postmark/inbound_emails#create
#            rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                     action_mailbox/ingresses/relay/inbound_emails#create
#         rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                  action_mailbox/ingresses/sendgrid/inbound_emails#create
#   rails_mandrill_inbound_health_check GET    /rails/action_mailbox/mandrill/inbound_emails(.:format)                                  action_mailbox/ingresses/mandrill/inbound_emails#health_check
#         rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                  action_mailbox/ingresses/mandrill/inbound_emails#create
#          rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                              action_mailbox/ingresses/mailgun/inbound_emails#create
#        rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#index
#                                       POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#create
#     new_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/new(.:format)                             rails/conductor/action_mailbox/inbound_emails#new
#    edit_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id/edit(.:format)                        rails/conductor/action_mailbox/inbound_emails#edit
#         rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#show
#                                       PATCH  /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       PUT    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       DELETE /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#destroy
# rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                      rails/conductor/action_mailbox/reroutes#create
#                    rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#             rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#                    rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#             update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#                  rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create
