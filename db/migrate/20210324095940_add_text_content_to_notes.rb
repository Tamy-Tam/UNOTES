class AddTextContentToNotes < ActiveRecord::Migration[6.0]
  def change
     add_column :notes, :text_content, :text
     add_index :notes, :text_content
  end
end
