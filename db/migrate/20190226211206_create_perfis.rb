class CreatePerfis < ActiveRecord::Migration[5.2]
  def change
    create_table :perfis do |t|
      t.string :descricao

      t.timestamps
    end
  end
end
