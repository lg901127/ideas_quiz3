class AddAvatarToIdea < ActiveRecord::Migration
  def change
    add_column :ideas, :avatar, :bytea
  end
end
