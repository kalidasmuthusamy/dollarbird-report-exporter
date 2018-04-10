Rails.application.routes.draw do
  defaults format: :json do
    post '/export_report', to: 'application#export_report'
  end
end
