class CreateOdisseias < ActiveRecord::Migration[5.2]
  def change
    create_table :odisseias do |t|
      t.text :texto
      t.text :fonte

      t.timestamps
    end
  end
end
