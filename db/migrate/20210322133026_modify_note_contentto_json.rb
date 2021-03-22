class ModifyNoteContenttoJson < ActiveRecord::Migration[6.0]
  def change
    remove_column :notes, :content
    add_column :notes, :json_content, :jsonb, null:false, default:'{}'
  end
end
