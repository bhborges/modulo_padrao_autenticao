class CreateRecursos < ActiveRecord::Migration[5.2]
  def change
    create_table :recursos do |t|
      t.string :nome
      t.string :descricao
      t.string :tipo

      t.timestamps
    end
  end
end
