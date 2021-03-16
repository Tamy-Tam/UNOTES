class CreateYcourses < ActiveRecord::Migration[6.0]
  def change
    create_table :ycourses do |t|
      t.string :url
      t.string :title

      t.timestamps
    end
  end
end
