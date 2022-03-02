class AddUserToVisit < ActiveRecord::Migration[7.0]
  def change
    add_reference :visits, :user, null: false, foreign_key: true
  end
end
