class ChangeIdeaAvatarToBytea < ActiveRecord::Migration
  def change
    remove_column :ideas, :avatar
  end
end
