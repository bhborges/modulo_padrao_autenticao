class CreatePermissoes < ActiveRecord::Migration[5.2]
  def change
    create_table :permissoes do |t|
      t.references :recurso, foreign_key: true
      t.references :perfil, foreign_key: true
      t.boolean :visualizar
      t.boolean :criar
      t.boolean :atualizar
      t.boolean :excluir

      t.timestamps
    end
  end
end
