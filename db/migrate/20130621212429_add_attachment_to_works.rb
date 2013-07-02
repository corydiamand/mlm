class AddAttachmentToWorks < ActiveRecord::Migration
  def change
    add_column :works, :attachment, :string
  end
end
