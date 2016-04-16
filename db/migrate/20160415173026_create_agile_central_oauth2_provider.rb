class CreateAgileCentralOauth2Provider < ActiveRecord::Migration
  def change
    AuthenticationProvider.create(name: 'agile_central')
  end
end
