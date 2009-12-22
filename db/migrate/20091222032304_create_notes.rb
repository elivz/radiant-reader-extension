class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.string :title
      t.text :note
      t.column :reader_id, :integer
      t.timestamps
    end
    
    remove_column :readers, :notes
  end

  def self.down
    drop_table :notes
    
    add_column :readers, :notes, :text
  end
end
