class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.string :title
      t.text :content
      t.boolean :visible
      t.references :user, null: false, foreign_key: true
      t.references :ycourse, null: false, foreign_key: true

      t.timestamps
    end
  end
end
