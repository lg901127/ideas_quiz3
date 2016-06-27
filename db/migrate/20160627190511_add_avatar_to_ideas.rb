class AddAvatarToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :avatar, :string
  end
end
